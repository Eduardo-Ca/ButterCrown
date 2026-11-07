#region BARRA DE COOLDOWN
draw_self();

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