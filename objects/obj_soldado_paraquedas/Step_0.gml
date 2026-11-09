if (global.pausado) exit;

event_inherited();

var _chao = instance_exists(obj_chao) ? obj_chao.bbox_top : room_height;

#region EFEITO AO SER ACERTADO
if (assustado && !paraquedas_rasgou) {
    paraquedas_rasgou = true;
    alpha_para = 0;
    vel_y = -3;

    para_x = x;
    para_y = y - 12;
    para_vy = -2.2;
    para_t = 0;
    para_alpha = 1;

    repeat (6) {
        var _p = instance_create_layer(x, y - 12, "Instances", obj_poeira);
        _p.cor = choose(c_white, c_ltgray);
        _p.direction = random(360);
        _p.speed = random_range(1, 3);
        _p.tamanho_original = random_range(0.8, 1.5);
    }

    tocar_som(snd_bolha);

}
#endregion

#region MOVIMENTO
if (assustado) {
    if (!soldado_sumiu) {
        vel_y += 0.25;
        y += vel_y;
        rot_queda += 14;

        if (y + meia_altura >= _chao) {
            soldado_sumiu = true;
            repeat (10) {
                var _pc = instance_create_layer(x, _chao, "Instances", obj_poeira);
                _pc.cor = c_gray;
                _pc.direction = random_range(20, 160);
                _pc.speed = random_range(1, 3);
                _pc.tamanho_original = random_range(1, 2);
            }
        }
    }
} else if (pousou) {
    alpha_para = max(0, alpha_para - 0.03);
    ang_balanco = lerp(ang_balanco, 0, 0.1);
} else {
    tempo_balanco += 0.05;
    ang_balanco = sin(tempo_balanco) * ang_max;
    y += vel_queda;
    x += cos(tempo_balanco) * 0.35;

    if (y + meia_altura >= _chao) {
        y = _chao - meia_altura;
        pousou = true;
    }
}
#endregion

#region PARAQUEDAS SOLTO
if (paraquedas_rasgou) {
    para_t++;
    para_vy += 0.03;
    para_y += para_vy;
    para_x += sin(para_t * 0.18) * 1.2 - global.vel_mundo * 0.6;
    para_alpha = max(0, para_alpha - 0.018);

    if (soldado_sumiu && para_alpha <= 0) instance_destroy();
}
#endregion