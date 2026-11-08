#region TRAVA DE PAUSA
if (global.pausado) {
    image_speed = 0;
    exit;
}
image_speed = 1;
#endregion

#region TEMPO DE VIDA
vida--;
var _p = 1 - (vida / vida_max);
#endregion

#region MOVIMENTO
x += lengthdir_x(vel_vento, direcao) + global.vel_mundo;
y += lengthdir_y(vel_vento, direcao);
#endregion

#region VISUAL
image_angle = direcao;
var _esc = lerp(escala_ini, escala_fim, _p);
image_xscale = _esc;
image_yscale = (lengthdir_x(1, direcao) < 0) ? -_esc : _esc;
if (vida < 12) image_alpha = (vida / 12) * 0.85;
#endregion

#region RASTRO
timer_rastro++;
if (timer_rastro >= 2) {
    timer_rastro = 0;
    criar_rastro_dash(id, 0.09, 0.92, c_aqua);
}
#endregion

#region EMPURRAR OBSTACULOS E EFEITO DE ACERTO
with (obj_obstaculo) {
    if (place_meeting(x, y, other)) {
        vel_empurrao_x = lengthdir_x(other.forca_base_vento * leveza, other.direcao);
        vel_empurrao_y = lengthdir_y(other.forca_base_vento * leveza, other.direcao);
		

        if (other.da_energia && !other.deu_energia) {
            other.deu_energia = true;
            with (obj_borboleta) {
                if (energia_atual < energia_maxima) {
                    energia_atual++;
                    criar_texto_flutuante(x, y - 20, "+1", c_aqua, 2);
                }
            }
        }

        if (!variable_instance_exists(id, "vento_tocado")) {
            vento_tocado = true;
            tremer_tela(2);
            repeat (5) {
                var _pf = instance_create_layer(x, y, "Instances", obj_poeira);
                _pf.cor = c_aqua;
                _pf.tamanho_original = random_range(1.5, 3);
            }
        }
    }
}
#endregion

#region DESTRUICAO
if (vida <= 0) instance_destroy();
#endregion