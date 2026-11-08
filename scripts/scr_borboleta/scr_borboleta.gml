function reagir_impacto_borboleta(_inst_obstaculo, _inst_borboleta, _boost_vel, _pontos_caos, _sprite_fuga = noone) {
    with (_inst_obstaculo) {
        if (!_inst_borboleta.morto) {
			tocar_som(snd_golpe);
            tremer_tela(6);
            
            _inst_borboleta.vel_vertical = -5.5;
            _inst_borboleta.image_xscale = 1.4;
            _inst_borboleta.image_yscale = 0.6;
            _inst_borboleta.quiques_atuais = 0;
            
            image_xscale = 1.3;
            image_yscale = 0.7;
            
            global.vel_mundo = clamp(global.vel_mundo + _boost_vel, 0, global.velocidade_maxima);
            global.caos += _pontos_caos;
            
            assustado = true;
            if (_sprite_fuga != noone) {
                sprite_index = _sprite_fuga;
            }
        }
    }
}


function iniciar_meteoro() {
	if (morto || modo_meteoro || modo_foguete || modo_dobra) exit;
    with (obj_borboleta) {
        if (morto || modo_meteoro || modo_foguete) exit;

        modo_meteoro = true;
        timer_meteoro = 0;
        vel_vertical = 6;
        sprite_index = spr_buttercrown;
        image_index = 0;

        tocar_som(snd_estrela);
        tremer_tela(4);
        zoom_punch(-0.06);
    }
}

function iniciar_dobra() {
    with (obj_borboleta) {
        if (morto || modo_meteoro || modo_foguete || modo_dobra) exit;

        modo_dobra = true;
        timer_dobra = 0;
        vel_vertical = 0;
        sprite_index = spr_buttercrown;
        image_index = 0;
        image_angle = 0;
		dobra_y_base = y;
        dobra_off = 0;
        dobra_off_alvo = 0;
        dobra_troca = 0;

        tocar_som(snd_estrela);
        tremer_tela(6);
        zoom_punch(-0.12);
        instance_create_depth(0, 0, 500, obj_dobra);
    }
}

function invocar_sapo() {
    if (!instance_exists(obj_borboleta) || obj_borboleta.morto) return false;
    if (instance_exists(obj_sapo_mago)) return false;

    var _b = obj_borboleta;
    var _s = instance_create_layer(_b.x - 45, _b.y - 40, "Instances", obj_sapo_mago);

    repeat (20) {
        var _p = instance_create_layer(_s.x, _s.y, "Instances", obj_poeira);
        _p.cor = choose(make_color_rgb(190, 90, 255), c_fuchsia, c_lime);
        _p.direction = random(360);
        _p.speed = random_range(1.5, 4);
        _p.tamanho_original = random_range(1, 2.5);
    }

    tocar_som(snd_estrela);
    tremer_tela(4);
    zoom_punch(-0.06);
    return true;
}

function iniciar_tornados() {
    if (!instance_exists(obj_borboleta)) return false;
    var _b = obj_borboleta;
    if (_b.morto || _b.modo_meteoro || _b.modo_foguete || _b.modo_dobra || _b.modo_tornado) return false;

    with (_b) {
        modo_tornado = true;
        timer_tornado = 0;
        vel_vertical = min(vel_vertical, -2);

        repeat (20) {
            var _p = instance_create_layer(x, y, "Instances", obj_poeira);
            _p.cor = choose(c_aqua, c_white);
            _p.direction = random(360);
            _p.speed = random_range(2, 4);
            _p.tamanho_original = random_range(1, 2);
        }
    }

    tocar_som(snd_up);
    tremer_tela(8);
    zoom_punch(-0.1);
    return true;
}