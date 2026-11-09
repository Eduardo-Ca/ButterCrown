#region PAUSA
if (global.pausado) {
    image_speed = 0; 
    exit;            
} else {
    image_speed = 1;
}
#endregion

if (cooldown_vento_timer > 0) {
    cooldown_vento_timer--;
}

if (tempo_atordoada > 0) tempo_atordoada--;

if (!morto) {
    energia_maxima = global.energia_maxima;
    energia_atual = clamp(energia_atual, 0, energia_maxima);


    #region PODERES 
    
    #region FOGUETE
    if (modo_foguete) {
        timer_foguete++;

        var _vy_cam = camera_get_view_y(view_camera[0]);
        var _vh_cam = camera_get_view_height(view_camera[0]);
        var _alvo = clamp(mouse_y, _vy_cam + 30, _vy_cam + _vh_cam - 30);
        if (timer_foguete < foguete_lancamento) _alvo = min(_alvo, y_foguete_ini - 110);

        var _vy = clamp((_alvo - y) * 0.15, -foguete_vel_max, foguete_vel_max);
        if (!place_meeting(x, y + _vy, obj_chao)) y += _vy; else _vy = 0;

        vel_vertical = _vy * 0.5;
        quiques_atuais = 0;
        ang_foguete = lerp(ang_foguete, clamp(-_vy * 4, -45, 45), 0.25);
        image_angle = ang_foguete * 0.3;
        image_xscale = lerp(image_xscale, 1, 0.1);
        image_yscale = lerp(image_yscale, 1, 0.1);
        x = lerp(x, posicao_x_base + 30, 0.08);

        global.vel_mundo = lerp(global.vel_mundo, global.velocidade_maxima * foguete_vel_mundo, 0.15);

        timer_rastro++;
        if (timer_rastro >= 2) {
            timer_rastro = 0;
            criar_rastro_dash(id, 0.1, 0.9, c_orange);
        }

        if (timer_foguete >= foguete_duracao) {
            modo_foguete = false;
            vel_vertical = -3;
            energia_atual = min(energia_atual + 1, energia_maxima);
            image_angle = 0;

            tremer_tela(10);
            zoom_punch(0.12);
            tocar_som(snd_explosao);
            criar_texto_flutuante(x, y - 20, "+1", c_lime, 3);

            var _inst = instance_create_layer(0, 0, "Instances", obj_fogos);
            for (var i = 0; i < 4; i++) {
                array_push(_inst.foguetes, {
                    pos_x: x,
                    pos_y: y,
                    alvo_y: y - random_range(40, 90),
                    vel_x: random_range(-1, 3),
                    vel_y: random_range(6, 9),
                    cor_explosao: choose(c_lime, c_aqua, c_fuchsia, c_yellow, c_orange)
                });
            }
        }

        exit;
    }
    #endregion
	
	    #region METEORO
    if (instance_exists(meteoro_alvo)) {
        var _ax = meteoro_alvo.x;
        var _ay = meteoro_alvo.y;

        repeat (12) {
            var _pa = instance_create_layer(_ax, _ay, "Instances", obj_poeira);
            _pa.cor = choose(c_orange, c_yellow, c_white);
            _pa.direction = random(360);
            _pa.speed = random_range(1.5, 4);
            _pa.tamanho_original = random_range(1.2, 2.5);
        }

        var _ex = instance_create_layer(_ax, _ay, "Instances", obj_explosao_construcao);
        _ex.raio_explosao = 220;
        _ex.image_xscale = 1.5;
        _ex.image_yscale = 1.5;

        tremer_tela(10);
        zoom_punch(0.12);
        with (meteoro_alvo) instance_destroy();
    }
    meteoro_alvo = noone;

    if (modo_meteoro) {
        timer_meteoro++;
        vel_vertical = min(vel_vertical + 1.2, meteoro_vel_max);

        image_angle = lerp(image_angle, -75, 0.3);
        image_xscale = lerp(image_xscale, 0.7, 0.2);
        image_yscale = lerp(image_yscale, 1.4, 0.2);
        x = lerp(x, posicao_x_base, 0.1);
        global.vel_mundo = lerp(global.vel_mundo, global.velocidade_maxima, 0.1);

        timer_rastro++;
        if (timer_rastro >= 2) {
            timer_rastro = 0;
            criar_rastro_dash(id, 0.1, 0.9, c_orange);
        }

        #region CONTATO COM OBSTACULOS
        var _x1 = bbox_left - 6;
        var _x2 = bbox_right + 6;
        var _y1 = bbox_top;
        var _y2 = bbox_bottom + max(vel_vertical, 0) + 6;
        var _hit = noone;

        with (obj_obstaculo) {
            if (!(bbox_right < _x1 || bbox_left > _x2 || bbox_bottom < _y1 || bbox_top > _y2)) {
                if (assustado) {
                    repeat (4) {
                        var _pp = instance_create_layer(x, y, "Instances", obj_poeira);
                        _pp.cor = choose(c_orange, c_yellow, c_white);
                        _pp.direction = random(360);
                        _pp.speed = random_range(1.5, 3.5);
                        _pp.tamanho_original = random_range(1, 2);
                    }

                    if (object_index == obj_balao_bomba) {
                        x = -400;
                    } else {
                        instance_destroy();
                    }
                } else if (_hit == noone) {
                    _hit = id;
                }
            }
        }

        if (_hit != noone) {
            modo_meteoro = false;
            meteoro_alvo = _hit;
            quiques_atuais = 0;
            vel_vertical = -1;
            y = clamp(_hit.y, y, y + max(vel_vertical, 0) + 22);
            while (place_meeting(x, y, obj_chao)) y -= 1;
            exit;
        }
        #endregion

        if (place_meeting(x, y + vel_vertical, obj_chao)) {
            while (!place_meeting(x, y + 1, obj_chao)) y += 1;

            modo_meteoro = false;
            vel_vertical = meteoro_quique;
            quiques_atuais = 0;
            image_angle = 0;
            image_xscale = 1.8;
            image_yscale = 0.4;
            global.vel_mundo = min(global.vel_mundo + 1.5, global.velocidade_maxima);

            tremer_tela(20);
            zoom_punch(0.2);
            tocar_som(snd_explosao);
            instance_create_layer(x, y + 8, "Instances", obj_explosao_construcao);

            repeat (24) {
                var _p = instance_create_layer(x, y + 10, "Instances", obj_poeira);
                _p.cor = choose(c_orange, c_yellow, c_white);
                _p.direction = 90 + random_range(-85, 85);
                _p.speed = random_range(2, 6);
                _p.tamanho_original = random_range(1.5, 3);
            }

            var _cx = x;
            var _cy = y;
            var _total = 0;
            with (obj_obstaculo) {
                if (!assustado && !construcao && point_distance(x, y, _cx, _cy) <= other.meteoro_raio) {
                    assustado = true;
                    sprite_index = sprite_assustado;
                    global.caos += pontos_caos;
                    _total += pontos_caos;
                }
            }
            if (_total > 0) criar_texto_flutuante(x, y - 30, "+" + string(_total), c_yellow, 3);
        } else {
            y += vel_vertical;
        }

        exit;
    }
    #endregion
	
	#region DOBRA
    if (modo_dobra) {
        timer_dobra++;

        quiques_atuais = 0;

        dobra_troca--;
        if (dobra_troca <= 0) {
            dobra_troca = irandom_range(8, 20);
            dobra_off_alvo = random_range(-dobra_amplitude, dobra_amplitude);
        }
        dobra_off = lerp(dobra_off, dobra_off_alvo, 0.15);

        var _cam_y = camera_get_view_y(view_camera[0]);
        var _cam_h = camera_get_view_height(view_camera[0]);
        var _y_alvo = dobra_y_base + dobra_off + sin(timer_dobra * 0.4) * 10;
        _y_alvo = clamp(_y_alvo, _cam_y + 30, _cam_y + _cam_h - 30);

        var _y_ant = y;
        var _novo_y = lerp(y, _y_alvo, 0.25);
        if (!place_meeting(x, _novo_y, obj_chao)) y = _novo_y;

        vel_vertical = 0;
        image_angle = lerp(image_angle, clamp((y - _y_ant) * -4, -35, 35), 0.3);
        image_xscale = lerp(image_xscale, 1.3, 0.2);
        image_yscale = lerp(image_yscale, 0.85, 0.2);
        x = lerp(x, posicao_x_base + 70, 0.08);

        global.vel_mundo = lerp(global.vel_mundo, global.velocidade_maxima * dobra_vel_mundo, 0.12);

        timer_rastro++;
        if (timer_rastro >= 2) {
            timer_rastro = 0;
            criar_rastro_dash(id, 0.15, 0.9, make_color_hsv((current_time * 0.4) mod 256, 255, 255));
        }

        var _x1 = bbox_left - 8;
        var _x2 = bbox_right + global.vel_mundo + 24;
        var _y1 = bbox_top - 8;
        var _y2 = bbox_bottom + 8;
        var _fim = false;
        var _qtd = 0;

        with (obj_obstaculo) {
            if (!(bbox_right < _x1 || bbox_left > _x2 || bbox_bottom < _y1 || bbox_top > _y2)) {
                if (construcao) {
                    if (!assustado) _fim = true;
                } else {
                    if (!assustado) {
                        global.caos += pontos_caos;
                        _qtd++;
                    }

                    repeat (6) {
                        var _p = instance_create_layer(x, y, "Instances", obj_poeira);
                        _p.cor = choose(c_aqua, c_white, c_fuchsia);
                        _p.direction = random(360);
                        _p.speed = random_range(1.5, 4);
                        _p.tamanho_original = random_range(1.2, 2.5);
                    }

                    if (object_index == obj_balao_bomba) {
                        x = -400;
                    } else {
                        instance_destroy();
                    }
                }
            }
        }

        if (_qtd > 0) tremer_tela(3);

        if (timer_dobra >= dobra_duracao || _fim) {
            modo_dobra = false;
            vel_vertical = -2;
            global.vel_mundo = global.velocidade_maxima;

            tremer_tela(10);
            zoom_punch(0.15);
            tocar_som(snd_explosao);
        }

        exit;
    }
    #endregion
    
    #endregion

    #region AVISO DE ENERGIA BAIXA
    if (energia_atual == 1 && energia_anterior > 1) {
        tocar_som(snd_sem_energia);
        tremer_tela(3);
    }
    energia_anterior = energia_atual;
    #endregion

    #region INPUT E IMPULSO
     if (tempo_atordoada > 0) {
        if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) tocar_som(snd_sem_energia);
    } else if (energia_atual > 0) {
        if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
            tocar_som(snd_pulo);
            
            forca_impulso = global.forca_impulso;
            vel_vertical = forca_impulso;
            
            tempo_flutuacao = 0;
            energia_atual -= 1;
            
            boost_por_impulso = global.boost_por_impulso;
            velocidade_maxima = global.velocidade_maxima;
            global.vel_mundo = min(global.vel_mundo + boost_por_impulso, velocidade_maxima);
            
            image_xscale = 0.5;
            image_yscale = 1.5;
        }
    } else if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
        tocar_som(snd_sem_energia);
    }
    #endregion

    #region GRAVIDADE
    vel_vertical += gravidade;
    #endregion

    #region COLISAO CHAO E QUIQUES
    if (place_meeting(x, y + vel_vertical, obj_chao)) {
        while (!place_meeting(x, y + sign(vel_vertical), obj_chao)) {
            y += sign(vel_vertical);
        }
        
        quiques_atuais += 1;
        timer_recupera_quiques = 0;
        
        boost_por_impulso = global.boost_por_impulso;
        velocidade_maxima = global.velocidade_maxima;
        global.vel_mundo = min(global.vel_mundo + (boost_por_impulso / 3), velocidade_maxima);
        
        image_xscale = 1.5;
        image_yscale = 0.5;
        
        quiques_maximos = global.quiques_maximos;
        if (quiques_atuais >= quiques_maximos || global.vel_mundo <= global.vel_minima_parada) {
            morto = true;
            tocar_som(snd_sem_energia);
        } else {
            tocar_som(snd_pulo);
            forca_quique = -2.8 + (quiques_maximos / 10);
            vel_vertical = forca_quique;
        }
    } else {
        y += vel_vertical;
        
        if (energia_atual > 0 && vel_vertical >= -1) {
            tempo_flutuacao += 0.1;
            y += sin(tempo_flutuacao) * 0.5;
        }
        
        if (quiques_atuais > 0 && energia_atual > 0) {
            timer_recupera_quiques += 1;
            if (timer_recupera_quiques >= tempo_recarrega_quiques) {
                quiques_atuais = 0;
                timer_recupera_quiques = 0;
            }
        }
    }
    #endregion

    #region PARADA NO CHAO
    if (global.vel_mundo <= global.vel_minima_parada && place_meeting(x, y + 1, obj_chao)) {
        morto = true;
        tocar_som(snd_sem_energia);
    }
    #endregion

    #region TRANSICAO DE MORTE
    if (morto) {
        energia_atual = 0;
        vel_vertical = 0;
        global.vel_mundo = 0;
        
        sprite_index = spr_buttercrown_caido;
        image_angle = 0;
        image_xscale = 1;
        image_yscale = 1;
        
        while (place_meeting(x, y, obj_chao)) {
            y -= 1;
        }
        while (!place_meeting(x, y + 1, obj_chao)) {
            y += 1;
        }
    }
    #endregion

    #region ANIMACAO SQUASH STRETCH
    if (!morto) {
        image_xscale = lerp(image_xscale, 1, 0.1);
        image_yscale = lerp(image_yscale, 1, 0.1);
    }
    #endregion

    #region POSICIONAMENTO X
    if (!morto) {
        x = lerp(x, posicao_x_base, retorno_x_velocidade);
    }
    #endregion

    #region ROTACAO VISUAL
    if (!morto) {
        if (energia_atual > 0) {
            var angulo_alvo = clamp(-vel_vertical * 4, -30, 45);
            image_angle = lerp(image_angle, angulo_alvo, 0.1);
        } else {
            image_angle += 8; 
        }
    }
    #endregion

       #region HABILIDADE 
    if (mouse_check_button_pressed(mb_right) && cooldown_vento_timer <= 0) {
        cooldown_vento_timer = cooldown_vento_max;

        sprite_index = spr_buttercrown_batendo_asas;
        image_index = 0;
        image_speed = 1;

        if (audio_exists(snd_vento)) {
            audio_play_sound(snd_vento, 5, false);
        }

        var dir_mouse = point_direction(x, y, mouse_x, mouse_y);
        var _sx = x + lengthdir_x(20, dir_mouse);
        var _sy = y + lengthdir_y(20, dir_mouse);

        var efx = instance_create_layer(_sx, _sy, "Instances", obj_vento);
        efx.pai = id;
        efx.direcao = dir_mouse;
        efx.image_angle = dir_mouse;

        tremer_tela(3);
        x -= lengthdir_x(6, dir_mouse);

        repeat (6) {
            var _pf = instance_create_layer(_sx, _sy, "Instances", obj_poeira);
            _pf.cor = c_aqua;
            _pf.direction = dir_mouse + random_range(-35, 35);
            _pf.speed = random_range(1.5, 3);
            _pf.tamanho_original = random_range(1.2, 2.5);
        }
    }

    if (sprite_index == spr_buttercrown_batendo_asas) {
        var delta_frame = (image_speed * sprite_get_speed(sprite_index)) / game_get_speed(gamespeed_fps);
        if (image_index + delta_frame >= image_number) {
            sprite_index = spr_buttercrown;
            image_index = 0;
        }
    }
    #endregion


    #region RASTRO
    timer_rastro += 1;
    if (timer_rastro >= 3) {
        timer_rastro = 0;
        criar_rastro_dash(id, 0.05, 0.9, c_yellow);
    }
    #endregion
}

#region TEMPO DE SER AFETADO PELA ONDA SONORA
if (afetado_por_onda) {
    tempo_reset_onda--;   
    if (tempo_reset_onda <= 0) {
        tempo_reset_onda = 20; 
        afetado_por_onda = false;
    }
}
#endregion

#region HABILIDADES DA LOJA
    for (var s = 0; s < array_length(global.hab_slots); s++) {
        if (keyboard_check_pressed(ord("1") + s)) usar_habilidade(s);
    }
	
#region TORNADOS (FURIA DOS VENTOS)
if (modo_tornado) {
    timer_tornado++;

    // solta os 3 ventos uma unica vez
    if (timer_tornado == tornado_carga) {
        var _dir = point_direction(x, y, mouse_x, mouse_y);

        for (var k = -1; k <= 1; k++) {
            var _v = instance_create_layer(x + lengthdir_x(20, _dir + k * tornado_espaco), y + lengthdir_y(20, _dir + k * tornado_espaco), "Instances", obj_vento);
            _v.pai = id;
            _v.direcao = _dir + k * tornado_espaco;
            _v.da_energia = true;
        }

        tocar_som(snd_vento);
        tremer_tela(6);
        zoom_punch(0.06);
        x -= lengthdir_x(8, _dir);
    }

    if (timer_tornado >= tornado_duracao) {
        modo_tornado = false;
    }
}
escala_poder = lerp(escala_poder, modo_tornado ? 2 : 1, 0.15);
#endregion
#endregion

#region QUEDA DEPOIS DE MORRER
if (morto && !place_meeting(x, y + 1, obj_chao)) {
    vel_vertical = min(vel_vertical + 0.4, 10);
    if (place_meeting(x, y + vel_vertical, obj_chao)) {
        while (!place_meeting(x, y + 1, obj_chao)) y += 1;
        vel_vertical = 0;
        image_xscale = 1.4;
        image_yscale = 0.6;
        tremer_tela(4);
    } else {
        y += vel_vertical;
    }
}
if (morto) {
    image_xscale = lerp(image_xscale, 1, 0.15);
    image_yscale = lerp(image_yscale, 1, 0.15);
}
#endregion


if(instance_exists(obj_cena_bomba)){
 energia_atual += 1;
}