if (global.pausado) exit;

x -= global.vel_mundo;
vida++;
timer++;
escala = lerp(escala, escala_alvo, 0.15);
squash = lerp(squash, 0, 0.15);

#region SUMIR
if (estourando) alpha -= 0.08;
else if (vida > vida_max - 40) alpha -= 1 / 40;

if (alpha <= 0 || x < camera_get_view_x(view_camera[0]) - 80) {
    instance_destroy();
    exit;
}
#endregion

#region SUPER PULO DA BORBOLETA
if (!estourando) {
    var _meia_l = sprite_get_width(spr_nuvem) * escala * 0.5 + 8;
    var _topo = y - sprite_get_height(spr_nuvem) * escala * 0.25;
    var _pulou = false;

    with (obj_borboleta) {
        if (!morto && !modo_meteoro && !modo_foguete && !modo_dobra && vel_vertical > 0
            && abs(x - other.x) < _meia_l
            && bbox_bottom >= _topo - 6
            && bbox_bottom <= _topo + 14 + vel_vertical) {

            y -= bbox_bottom - _topo;
            vel_vertical = other.forca_pulo;
            quiques_atuais = 0;
            tempo_flutuacao = 0;
            image_xscale = 1.5;
            image_yscale = 0.5;
            global.vel_mundo = min(global.vel_mundo + global.boost_por_impulso, global.velocidade_maxima);
            _pulou = true;
        }
    }

    if (_pulou) {
        estourando = true;
        escala_alvo = escala_alvo * 1.4;
        squash = 1;

        tocar_som(snd_pulo);
        tremer_tela(3);
        zoom_punch(-0.04);

        repeat (12) {
            var _p = instance_create_layer(x + random_range(-25, 25), _topo, "Instances", obj_poeira);
            _p.cor = choose(make_color_rgb(190, 90, 255), c_fuchsia, c_white);
            _p.direction = random(360);
            _p.speed = random_range(1.5, 3.5);
            _p.tamanho_original = random_range(1, 2);
        }
    }
}
#endregion