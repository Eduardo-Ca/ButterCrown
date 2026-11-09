#region AVISO DE FASE
if (banner_timer > 0) {
    var _gw = display_get_gui_width();
    var _entrada = min(1, (banner_max - banner_timer) / 20);
    var _alpha = min(_entrada, banner_timer / 30);
    var _y = 170 - (1 - _entrada) * 30;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_black);
    draw_set_alpha(0.55 * _alpha);
    draw_roundrect_ext(_gw / 2 - 180, _y - 45, _gw / 2 + 180, _y + 45, 14, 14, false);

    draw_set_alpha(_alpha);
    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _y - 20, banner_titulo, 1.2, 1.2, 0);

    draw_set_color(c_black);
    draw_text_transformed(_gw / 2 + 3, _y + 15 + 3, tr(banner_nome), 2.5, 2.5, 0);
    draw_set_color(banner_cor);
    draw_text_transformed(_gw / 2, _y + 15, tr(banner_nome), 2.5, 2.5, 0);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion