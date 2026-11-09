if (global.pausado) {
    image_speed = 0;
    exit;
}

image_speed = 1;
timer++;
flash = max(0, flash - 0.12);

var _b = noone;
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) _b = obj_borboleta;
if (_b == noone) estado = "saindo";

#region VENTO
var _v = instance_place(x, y, obj_vento);
if (_v != noone) {
    instance_destroy(_v);
    vida_heli--;
    flash = 1;
    x += 10;
    vel_avanco *= 0.4;
    tocar_som(snd_golpe);
    tremer_tela(4);

    repeat (6) {
        var _p = instance_create_layer(x, y, "Instances", obj_poeira);
        _p.cor = choose(c_aqua, c_white, c_gray);
        _p.direction = random(360);
        _p.speed = random_range(1.5, 3.5);
        _p.tamanho_original = random_range(1, 2);
    }

    if (vida_heli <= 0) {
        instance_create_layer(x, y, "Instances", obj_explosao_construcao);
        repeat (24) {
            var _e = instance_create_layer(x, y, "Instances", obj_poeira);
            _e.cor = choose(c_orange, c_yellow, c_dkgray);
            _e.direction = random(360);
            _e.speed = random_range(2, 6);
            _e.tamanho_original = random_range(1.5, 3);
        }
        tocar_som(snd_explosao);
        tremer_tela(12);
        zoom_punch(0.1);
       global.caos += 3;
		criar_texto_flutuante(x, y - 30, "+2", c_lime, 3);

		if (instance_exists(obj_borboleta)) {
		    obj_borboleta.energia_atual = min(obj_borboleta.energia_atual + 2, obj_borboleta.energia_maxima);
		}
		
        if (instance_exists(obj_tanque)) obj_tanque.tomar_dano(1);
        instance_destroy();
        exit;
    }
}
#endregion

#region COMPORTAMENTO
var _cam_x = camera_get_view_x(view_camera[0]);

switch (estado) {
    case "entrando":
    case "mirando":
        var _ay = _b.y;
        if (instance_exists(obj_chao)) _ay = min(_ay, obj_chao.bbox_top - 70);

        y = lerp(y, _ay, 0.05);
        x = lerp(x, _b.posicao_x_base + dist_parado, 0.06);
        image_angle = lerp(image_angle, clamp((_ay - y) * 0.1, -10, 10), 0.1);

        if (estado == "entrando") {
            if (abs(x - (_b.posicao_x_base + dist_parado)) < 6) {
                estado = "mirando";
                timer_estado = tempo_mira;
            }
        } else {
            timer_estado--;
            if (timer_estado <= 0) {
                estado = "aviso";
                timer_estado = tempo_aviso;
                tocar_som(snd_sem_energia);
            }
        }
        break;

    case "aviso":
        timer_estado--;
        x = lerp(x, _b.posicao_x_base + dist_parado + 25, 0.1) + random_range(-1.5, 1.5);
        y += random_range(-1, 1);
        image_angle = lerp(image_angle, -6, 0.2);

        if (timer_estado <= 0) {
            estado = "avancando";
            vel_avanco = 2;
            tocar_som(snd_vento);
            tremer_tela(5);
        }
        break;

    case "avancando":
        vel_avanco = min(vel_max, vel_avanco + acel_avanco);
        x -= vel_avanco;
        image_angle = lerp(image_angle, 12, 0.2);

        timer_rastro++;
        if (timer_rastro >= 2) {
            timer_rastro = 0;
            criar_rastro_dash(id, 0.1, 0.9, c_red);
        }

        if (x < _cam_x - 120) instance_destroy();
        break;

    case "saindo":
        x += 6;
        y -= 1;
        if (x > _cam_x + camera_get_view_width(view_camera[0]) + 120) instance_destroy();
        break;
}
#endregion

#region TOCOU, MORREU
if (estado != "saindo" && collision_rectangle(x - 68, y - 22, x + 45, y + 25, obj_borboleta, false, true) != noone) {
    matar_borboleta();
}
#endregion