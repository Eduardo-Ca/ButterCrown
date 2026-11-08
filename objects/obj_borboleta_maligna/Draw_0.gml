#region AVISO DE MIRA
if (estado == "mirando") {
    var _pisca = 0.4 + abs(sin(tempo * 0.4)) * 0.6;
    gpu_set_blendmode(bm_add);
    draw_set_color(c_red);
    draw_set_alpha(0.3 * _pisca);
    draw_circle(x, y, 14 * escala_base, false);

    // linha tracejada ate o gato
    draw_set_alpha(0.7 * _pisca);
    for (var d = 10; d < 90; d += 12) {
        var _x1 = x + lengthdir_x(d, mergulho_dir);
        var _y1 = y + lengthdir_y(d, mergulho_dir);
        var _x2 = x + lengthdir_x(d + 6, mergulho_dir);
        var _y2 = y + lengthdir_y(d + 6, mergulho_dir);
        draw_line_width(_x1, _y1, _x2, _y2, 2);
    }
    gpu_set_blendmode(bm_normal);
}
#endregion

#region BRILHO DA RAINHA
if (tipo == "rainha") {
    gpu_set_blendmode(bm_add);
    draw_set_color(cor);
    draw_set_alpha(0.2 + sin(tempo * 0.1) * 0.08);
    draw_circle(x, y, 20 * escala_base, false);
    gpu_set_blendmode(bm_normal);
}
#endregion

#region BORBOLETA (com flash branco ao levar dano)
draw_set_alpha(1);
if (flash > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);