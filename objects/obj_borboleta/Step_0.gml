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

if (!morto) {
    
    energia_atual = clamp(energia_atual, 0, energia_maxima);

    #region INPUT E IMPULSO
    if ((mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) && energia_atual > 0) {
        tocar_som(snd_pulo);
        vel_vertical = forca_impulso;
        energia_atual -= 1;
        global.vel_mundo = min(global.vel_mundo + boost_por_impulso, global.velocidade_maxima);
        image_xscale = 0.5;
        image_yscale = 1.5;
    }
    if (mouse_check_button_pressed(mb_left) && energia_atual <= 0) {
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
        
        global.vel_mundo = max(0, global.vel_mundo - global.atrito_chao * 3);
        
        image_xscale = 1.5;
        image_yscale = 0.5;
        
        if (quiques_atuais >= quiques_maximos || global.vel_mundo <= global.vel_minima_parada) {
            morto = true;
            tocar_som(snd_sem_energia);
        } else {
            tocar_som(snd_pulo);
            vel_vertical = forca_quique;
        }
    } else {
        y += vel_vertical;
        
        if (energia_atual > 0) {
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
        if (energia_atual > 0 || global.vel_mundo > 2) {
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
    vento_disparado = false; 
}

if (sprite_index == spr_buttercrown_batendo_asas) {
    
    if (floor(image_index) == 2 && !vento_disparado) {
        vento_disparado = true;
        
        if (audio_exists(snd_vento)) {
            audio_play_sound(snd_vento, 5, false);
        }
        
        var dir_mouse = point_direction(x, y, mouse_x, mouse_y);
        
        var efx = instance_create_layer(x + 20, y, "Instances", obj_vento);
        efx.pai = id;
        efx.direcao = dir_mouse; 

    }

    if (image_index + (image_speed * sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps)) >= image_number) {
        sprite_index = spr_buttercrown;
        image_index = 0;
    }
}
#endregion

}