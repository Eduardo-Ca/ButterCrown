if (alpha <= 0) exit;

var _w = sprite_get_width(sprite_index) * escala;
var _h = sprite_get_height(sprite_index) * escala;
var _roxo = make_color_rgb(190, 90, 255);
var _pulso = 1 + sin(timer * 0.15) * 0.15;
var _ang = sin(timer * 0.06) * 8 - cast * 15;
var _xs = escala * (1 + pulo * 0.15);
var _ys = escala * (1 - pulo * 0.15);

#region PONTA DO CAJADO (gira junto)
var _dx = _w * ponta_x;
var _dy = _h * ponta_y;
var _len = point_distance(0, 0, _dx, _dy);
var _dir = point_direction(0, 0, _dx, _dy) + _ang;
var _px = x + lengthdir_x(_len, _dir);
var _py = y + lengthdir_y(_len, _dir);
#endregion

gpu_set_blendmode(bm_add);

#region AURA
draw_set_color(_roxo);
draw_set_alpha(0.18 * alpha);
draw_circle(x, y, _h * 0.75 * _pulso, false);
draw_set_alpha(0.10 * alpha);
draw_circle(x, y, _h * 1.0 * _pulso, false);

// contorno brilhante
draw_sprite_ext(sprite_index, image_index, x, y, _xs * 1.15, _ys * 1.15, _ang, _roxo, 0.5 * alpha);
#endregion

#region CRISTAIS ORBITANDO
for (var i = 0; i < 3; i++) {
    var _a = orbita + i * 120;
    var _ox = x + lengthdir_x(_h * 0.8, _a);
    var _oy = y + lengthdir_y(_h * 0.35, _a);
    var _t = 2 + sin(timer * 0.2 + i);

    draw_set_color(make_color_hsv((timer * 2 + i * 60) mod 256, 160, 255));
    draw_set_alpha(alpha);
    draw_triangle(_ox, _oy - _t * 2, _ox + _t, _oy, _ox - _t, _oy, false);
    draw_triangle(_ox, _oy + _t * 2, _ox + _t, _oy, _ox - _t, _oy, false);
}
#endregion

gpu_set_blendmode(bm_normal);

#region SAPO
draw_sprite_ext(sprite_index, image_index, x, y, _xs, _ys, _ang, c_white, alpha);

// flash ao lancar o feitico
if (cast > 0) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, _xs, _ys, _ang, c_white, cast * 0.5 * alpha);
    gpu_set_blendmode(bm_normal);
}
#endregion

gpu_set_blendmode(bm_add);

#region BRILHO DO CAJADO
draw_set_color(c_fuchsia);
draw_set_alpha(0.5 * alpha);
draw_circle(_px, _py, (3 + cast * 6) * _pulso, false);
draw_set_color(c_white);
draw_set_alpha(0.8 * alpha);
draw_circle(_px, _py, 1.5 + cast * 2, false);
#endregion

#region RAIO MAGICO
if (raio_t > 0 && instance_exists(raio_alvo)) {
    var _seg = 6;
    var _x0 = _px;
    var _y0 = _py;
    var _perp = point_direction(_px, _py, raio_alvo.x, raio_alvo.y) + 90;

    for (var i = 1; i <= _seg; i++) {
        var _f = i / _seg;
        var _x1 = lerp(_px, raio_alvo.x, _f);
        var _y1 = lerp(_py, raio_alvo.y, _f);
        if (i < _seg) {
            var _zz = random_range(-8, 8);
            _x1 += lengthdir_x(_zz, _perp);
            _y1 += lengthdir_y(_zz, _perp);
        }

        draw_set_alpha(raio_t * alpha);
        draw_set_color(_roxo);
        draw_line_width(_x0, _y0, _x1, _y1, 3);
        draw_set_color(c_white);
        draw_line_width(_x0, _y0, _x1, _y1, 1);

        _x0 = _x1;
        _y0 = _y1;
    }
}
#endregion

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);