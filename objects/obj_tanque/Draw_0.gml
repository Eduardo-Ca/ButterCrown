var _ex = image_xscale * escala_dano * escala_morte;
var _ey = image_yscale * escala_dano * escala_morte;

if (tempo_flash_dano > 0) gpu_set_fog(true, c_white, 0, 0);
draw_sprite_ext(sprite_index, image_index, x + recuo, y, _ex, _ey, image_angle, image_blend, image_alpha * alpha_morte);
gpu_set_fog(false, c_white, 0, 0);

#region AVISO DO TIRO
if (timer_tiro <= aviso_tiro) {
    var _f = 1 - timer_tiro / aviso_tiro;
    gpu_set_blendmode(bm_add);
    draw_set_color(c_orange);
    draw_set_alpha(0.3 + 0.5 * _f);
    draw_circle(x + MORTEIRO_X, y + MORTEIRO_Y, 3 + _f * 7 + sin(current_time * 0.03), false);
    gpu_set_blendmode(bm_normal);
}
#endregion

#region TIROS E MIRA
for (var i = 0; i < array_length(tiros); i++) {
    var _t = tiros[i];
    var _pulso = 0.5 + 0.5 * sin(current_time * 0.02);
    var _r = 8 + (1 - _t.tempo / duracao_tiro) * 18;

    draw_set_color(c_red);
    draw_set_alpha(0.45 + 0.45 * _pulso);
    draw_circle(_t.ax, _t.ay, _r, true);
    draw_line_width(_t.ax - 6, _t.ay, _t.ax + 6, _t.ay, 1);
    draw_line_width(_t.ax, _t.ay - 6, _t.ax, _t.ay + 6, 1);

    gpu_set_blendmode(bm_add);
    draw_set_color(c_orange);
    draw_set_alpha(0.5);
    draw_circle(_t.x, _t.y, 7, false);
    gpu_set_blendmode(bm_normal);

    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_circle(_t.x, _t.y, 4, false);
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);