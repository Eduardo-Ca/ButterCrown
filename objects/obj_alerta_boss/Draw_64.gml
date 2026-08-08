#region TRAVA DE PAUSA 
if (global.pausado) {
    exit;           
}
#endregion
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _centro_x = _gui_w / 2;
var _centro_y = _gui_h * 0.3;

var _alpha = (sin(tempo_pisca) * 0.3) + 0.7;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_text_transformed(_centro_x + 3, _centro_y + 3, "ALERTA DE BOSS!", 2 * escala, 2 * escala, 0);

draw_set_color(c_red);
draw_set_alpha(_alpha);
draw_text_transformed(_centro_x, _centro_y, "ALERTA DE BOSS!", 2 * escala, 2 * escala, 0);

draw_set_color(c_yellow);
draw_text_transformed(_centro_x, _centro_y + 35, string(texto_titulo), 1.2 * escala, 1.2 * escala, 0);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);