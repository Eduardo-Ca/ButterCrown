#region AURA DA FURIA DOS VENTOS
if (modo_tornado && !morto) {
    var _pul = 1 + sin(current_time * 0.015) * 0.1;
    gpu_set_blendmode(bm_add);

    draw_set_color(c_aqua);
    draw_set_alpha(0.18);
    draw_circle(x, y, 20 * escala_poder * _pul, false);
    draw_set_alpha(0.10);
    draw_circle(x, y, 30 * escala_poder * _pul, false);

    draw_set_color(c_white);
    draw_set_alpha(0.6);
    var _r = 22 * escala_poder;
    for (var k = 0; k < 3; k++) {
        var _a0 = current_time * 0.4 + k * 120;
        for (var s = 0; s < 6; s++) {
            var _a1 = _a0 + s * 8;
            var _a2 = _a1 + 8;
            draw_line_width(x + lengthdir_x(_r, _a1), y + lengthdir_y(_r * 0.5, _a1),
                            x + lengthdir_x(_r, _a2), y + lengthdir_y(_r * 0.5, _a2), 1.5);
        }
    }

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
#endregion

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * escala_poder, image_yscale * escala_poder, image_angle, image_blend, image_alpha);

#region BARRA DE COOLDOWN
if (cooldown_vento_timer > 0 && !morto) {
    var pct = 1 - (cooldown_vento_timer / cooldown_vento_max);
    
    var bar_w = 32;
    var bar_h = 4;
    var bx = x - (bar_w / 2);
    var by = y - 35; 
    
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(bx - 1, by - 1, bx + bar_w + 1, by + bar_h + 1, false);
    
    draw_set_color(c_aqua);
    draw_set_alpha(0.9);
    draw_rectangle(bx, by, bx + (bar_w * pct), by + bar_h, false);
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
#endregion

#region poderes obstaculos
#region FOGUETE
if (modo_foguete && !morto) {
    draw_sprite_ext(spr_foguete, floor(timer_foguete * 0.4), x, y + 10, 1, 1, ang_foguete, c_white, 1);
}
#endregion



#endregion

#region METEORO
if (modo_meteoro && !morto) {
    var _f = 1 + sin(timer_meteoro * 0.9) * 0.15;

    gpu_set_blendmode(bm_add);

    for (var i = 5; i >= 1; i--) {
        draw_set_color(c_orange);
        draw_set_alpha(0.12 * (6 - i));
        draw_circle(x - i * 2, y - i * 9, (18 - i * 2) * _f, false);
    }

    draw_set_color(c_orange);
    draw_set_alpha(0.55);
    draw_circle(x, y, 22 * _f, false);

    draw_set_color(c_yellow);
    draw_set_alpha(0.7);
    draw_circle(x, y, 13 * _f, false);

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
#endregion

#region DOBRA
if (modo_dobra && !morto) {
    var _h = (current_time * 0.4) mod 256;

    gpu_set_blendmode(bm_add);

    for (var k = 0; k < 6; k++) {
        var _ly = y + (k - 2.5) * 3;
        draw_set_color(make_color_hsv((_h + k * 30) mod 256, 255, 255));
        draw_set_alpha(0.8);
        draw_line_width(x - 8, _ly, x - 70 - random(50), _ly, 2);
    }

    for (var i = 3; i >= 1; i--) {
        draw_sprite_ext(sprite_index, image_index, x - i * 7, y, image_xscale, image_yscale, image_angle, make_color_hsv((_h + i * 40) mod 256, 200, 255), 0.5 / i);
    }

    var _pulso = 1 + sin(current_time * 0.02) * 0.1;
    draw_set_color(make_color_hsv(_h, 120, 255));
    draw_set_alpha(0.25);
    draw_circle(x, y, 20 * _pulso, false);
    draw_set_alpha(0.15);
    draw_circle(x, y, 32 * _pulso, false);

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
#endregion

#region ATORDOADA
if (tempo_atordoada > 0 && !morto) {
    draw_set_color(c_yellow);
    for (var k = 0; k < 3; k++) {
        var _a = current_time * 0.4 + k * 120;
        draw_circle(x + lengthdir_x(16, _a), y - 18 + lengthdir_y(5, _a), 2, false);
    }
    draw_set_color(c_white);
}
#endregion

#region MIRA DO VENTO
if (!morto && !modo_meteoro && !modo_foguete && !modo_dobra) {
    var _pronto = (cooldown_vento_timer <= 0);
    var _dir = point_direction(x, y, mouse_x, mouse_y);
    var _dist = min(point_distance(x, y, mouse_x, mouse_y), 320);
    var _esp = 14;
    var _mov = (current_time * 0.03) mod _esp;

    draw_set_color(_pronto ? c_aqua : c_gray);

    for (var d = 24 + _mov; d < _dist; d += _esp) {
        draw_set_alpha((_pronto ? 0.55 : 0.2) * (1 - d / 400));
        draw_circle(x + lengthdir_x(d, _dir), y + lengthdir_y(d, _dir), 1.2, false);
    }

    var _px = x + lengthdir_x(_dist, _dir);
    var _py = y + lengthdir_y(_dist, _dir);

    draw_set_alpha(_pronto ? 0.8 : 0.3);
    draw_circle(_px, _py, _pronto ? 5 + sin(current_time * 0.012) : 4, true);

    draw_set_alpha(1);
    draw_set_color(c_white);
}
#endregion

