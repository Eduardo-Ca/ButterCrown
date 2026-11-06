if (global.pausado) {
    image_speed = 0;
    exit;
}
image_speed = 1;

vida--;
var _p = 1 - (vida / vida_max);

var _alvo = noone;
var _melhor = 99999;
with (obj_obstaculo) {
    if (!assustado && !construcao) {
        var _d = point_distance(other.x, other.y, x, y);
        if (_d <= 260) {
            var _dif = abs(angle_difference(point_direction(other.x, other.y, x, y), other.direcao));
            if (_dif <= 40) {
                var _nota = _d + _dif * 3;
                if (_nota < _melhor) {
                    _melhor = _nota;
                    _alvo = id;
                }
            }
        }
    }
}

if (_alvo != noone) {
    var _dir_alvo = point_direction(x, y, _alvo.x, _alvo.y);
    direcao += clamp(angle_difference(_dir_alvo, direcao), -9, 9);
}

x += lengthdir_x(vel_vento, direcao) + global.vel_mundo;
y += lengthdir_y(vel_vento, direcao);
image_angle = direcao;

var _esc = lerp(escala_ini, escala_fim, _p);
image_xscale = _esc;
image_yscale = _esc;
if (vida < 15) image_alpha = (vida / 15) * 0.85;

timer_rastro++;
if (timer_rastro >= 2) {
    timer_rastro = 0;
    criar_rastro_dash(id, 0.09, 0.92, c_aqua);
}

with (obj_obstaculo) {
    if (place_meeting(x, y, other)) {
        vel_empurrao_x = lengthdir_x(other.forca_base_vento * leveza, other.direcao);
        vel_empurrao_y = lengthdir_y(other.forca_base_vento * leveza, other.direcao);

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

if (vida <= 0) instance_destroy();