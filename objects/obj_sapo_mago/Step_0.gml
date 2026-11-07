if (global.pausado) exit;

timer++;
orbita += 4;
cast = max(0, cast - 0.06);
raio_t = max(0, raio_t - 0.1);
pulo = lerp(pulo, 0, 0.15);

var _b = instance_exists(obj_borboleta) ? obj_borboleta : noone;

#region FIM DO FEITICO
if (!saindo && (timer >= duracao || _b == noone || _b.morto)) {
    saindo = true;
    tocar_som(snd_estrela);
    repeat (20) {
        var _p = instance_create_layer(x, y, "Instances", obj_poeira);
        _p.cor = choose(make_color_rgb(190, 90, 255), c_fuchsia, c_lime);
        _p.direction = random(360);
        _p.speed = random_range(1.5, 4);
        _p.tamanho_original = random_range(1, 2);
    }
}
#endregion

#region MOVIMENTO
if (saindo) {
    x += 2;
    y -= 3;
    alpha -= 0.04;
    if (alpha <= 0) {
        instance_destroy();
        exit;
    }
} else {
    alpha = min(1, alpha + 0.08);
    x = lerp(x, _b.x - 45, 0.12);
    y = lerp(y, _b.y - 40 + sin(timer * 0.08) * 6, 0.12);
}
#endregion

#region CRIAR NUVENS
if (!saindo) {
    timer_nuvem--;
    if (timer_nuvem <= 0) {
        timer_nuvem = intervalo_nuvem;

        var _cy = camera_get_view_y(view_camera[0]);
        var _ch = camera_get_view_height(view_camera[0]);

        // distancia na frente da borboleta e quanto tempo a nuvem leva pra chegar nela
        var _vel = max(global.vel_mundo, 0.5);
        var _dist = clamp(_vel * 55, 90, 280);
        var _t = _dist / _vel;

        // onde a borboleta vai estar caindo nesse momento
        var _y_prev = _b.y + _b.vel_vertical * _t + 0.5 * _b.gravidade * _t * _t;

        var _nx = _b.x + _dist;
        var _ny = clamp(_y_prev + 18, _cy + 80, _cy + _ch - 60);

        // nao nasce dentro do chao
        while (_ny > _cy + 60 && collision_rectangle(_nx - 45, _ny - 10, _nx + 45, _ny + 20, obj_chao, false, true)) {
            _ny -= 8;
        }

        // nao nasce colada em outra nuvem
        if (collision_circle(_nx, _ny, 70, obj_nuvem_roxa, false, true) == noone) {
            raio_alvo = instance_create_layer(_nx, _ny, "Instances", obj_nuvem_roxa);
            raio_t = 1;
            cast = 1;
            pulo = 1;
            tocar_som(snd_bolha);
        } else {
            timer_nuvem = 10; // tenta de novo logo
        }
    }
}
#endregion

#region PARTICULAS
timer_particula++;
if (timer_particula >= 3) {
    timer_particula = 0;
    var _pt = instance_create_layer(x + random_range(-8, 8), y + 10, "Instances", obj_poeira);
    _pt.cor = choose(make_color_rgb(190, 90, 255), c_fuchsia, c_lime);
    _pt.tamanho_original = random_range(0.6, 1.2);
}
#endregion