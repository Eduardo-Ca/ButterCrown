if (global.pausado) exit;
if (!instance_exists(obj_gato_gigante)) { instance_destroy(); exit; }

tempo++;
flash = max(0, flash - 0.1);
if (inv > 0) inv--;

var _g = obj_gato_gigante;
var _tx = _g.x;
var _ty = _g.y - 30;

switch (estado) {
	case "surgindo":
        timer_surgir--;
        y += sin(tempo * 0.15) * 0.6;
        image_angle = sin(tempo * 0.2) * 6;
        if (timer_surgir <= 0) estado = "voando";
        break;
    case "voando":
        var _alvo = point_direction(x, y, _tx, _ty);
        dir += clamp(angle_difference(_alvo, dir), -4, 4);
        var _onda = sin(tempo * 0.12) * 35;
        x += lengthdir_x(vel, dir + _onda);
        y += lengthdir_y(vel, dir + _onda);
        image_angle = sin(tempo * 0.2) * 10;

        if (point_distance(x, y, _tx, _ty) < dist_mergulho) {
            estado = "mirando";
            timer_mira = mira_max;
        }
        break;

    case "mirando":
        timer_mira--;
        x += random_range(-1, 1);
        y += random_range(-1, 1);
        mergulho_dir = point_direction(x, y, _tx, _ty);
        image_angle = 0;

        if (timer_mira <= 0) {
            estado = "mergulho";
            timer_mergulho = 40;
        }
        break;

    case "mergulho":
        x += lengthdir_x(mergulho_vel, mergulho_dir);
        y += lengthdir_y(mergulho_vel, mergulho_dir);

        timer_rastro++;
        if (timer_rastro >= 2) {
            timer_rastro = 0;
            criar_rastro_dash(id, 0.1, 0.9, cor);
        }

        timer_mergulho--;
        if (timer_mergulho <= 0) estado = "voando"; // errou
        break;
}

#region VIRAR PRO LADO CERTO E BATER ASAS
var _olha_esq = (estado == "voando") ? (x - xprevious < 0) : (_tx < x);
image_xscale = (_olha_esq ? -1 : 1) * escala_base;
image_yscale = escala_base * (1 + sin(tempo * 0.6) * 0.1);
#endregion