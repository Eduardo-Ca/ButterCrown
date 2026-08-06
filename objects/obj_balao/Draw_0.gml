
if (sprite_index != -1) {
    draw_sprite_ext(
        sprite_index,
        image_index,
        x,
        y,
        image_xscale,
        image_yscale,
        image_angle,
        image_blend,
        image_alpha
    );
}


if (assustado && is_array(linhas_vento)) {
    draw_set_color(c_white);
    
    for (var i = 0; i < array_length(linhas_vento); i++) {
        var l = linhas_vento[i];
        
        var x1 = x + l.off_x;
        var y1 = y + l.off_y;
        var x2 = x1 - (vel_fuga_x * 2.5);
        var y2 = y1 - (vel_fuga_y * 2.5);
        
        draw_set_alpha(l.alpha);
        draw_line_width(x1, y1, x2, y2, 2);
        
        l.alpha -= 0.04;
        if (l.alpha <= 0) {
            l.off_x = random_range(-12, 12);
            l.off_y = random_range(-12, 12);
            l.alpha = 1;
        }
    }
    
    draw_set_alpha(1);
}