var _xs = escala * (1 + squash * 0.3);
var _ys = escala * (1 - squash * 0.35);
var _yy = y + sin(timer * 0.08) * 2;
var _roxo = make_color_rgb(170, 80, 255);

gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_nuvem, image_index, x, _yy, _xs * 1.15, _ys * 1.25, 0, _roxo, 0.35 * alpha);
gpu_set_blendmode(bm_normal);

draw_sprite_ext(spr_nuvem, image_index, x, _yy, _xs, _ys, 0, make_color_rgb(200, 140, 255), alpha);

#region BRILHINHOS
gpu_set_blendmode(bm_add);
for (var i = 0; i < 3; i++) {
    var _bx = x + sin(timer * 0.05 + i * 2) * 25 * escala / 0.6;
    var _by = _yy - 8 + cos(timer * 0.07 + i * 3) * 6;
    draw_set_color(c_white);
    draw_set_alpha((0.5 + sin(timer * 0.2 + i) * 0.5) * alpha);
    draw_circle(_bx, _by, 1.5, false);
}
gpu_set_blendmode(bm_normal);
#endregion

draw_set_alpha(1);
draw_set_color(c_white);