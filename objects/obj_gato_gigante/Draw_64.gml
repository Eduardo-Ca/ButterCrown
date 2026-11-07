event_inherited();

#region AVISO DO CHEFE
if (timer_aviso > 0 && vida_real > 0 && !morto) {
    var _gw = display_get_gui_width();
    var _prog = 1 - (timer_aviso / timer_aviso_max);
    var _alpha = min(1, _prog * 8, timer_aviso / 30);
    var _pulso = 1 + sin(current_time * 0.012) * 0.04;

    var _cx = _gw / 2;
    var _cy = 120;
    var _larg = string_width(texto_aviso) * 2 * _pulso;
    var _alt = 20 * 2 * _pulso;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_black);
    draw_set_alpha(0.65 * _alpha);
    draw_roundrect_ext(_cx - _larg / 2 - 24, _cy - _alt / 2 - 10, _cx + _larg / 2 + 24, _cy + _alt / 2 + 10, 12, 12, false);

    draw_set_color(c_black);
    draw_set_alpha(_alpha);
    draw_text_transformed(_cx + 2, _cy + 2, texto_aviso, 2 * _pulso, 2 * _pulso, 0);

    draw_set_color(c_yellow);
    draw_text_transformed(_cx, _cy, texto_aviso, 2 * _pulso, 2 * _pulso, 0);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion