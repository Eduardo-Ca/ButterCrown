#region TRAVA DE PAUSA
if (global.pausado||instance_exists(obj_loja)) exit;
#endregion
#region RENDERIZACAO COM SOMBRA
var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);
var _vw = camera_get_view_width(view_camera[0]);
var _vh = camera_get_view_height(view_camera[0]);
var gui_x = (x - _vx) * display_get_gui_width() / _vw;
var gui_y = (y - _vy) * display_get_gui_height() / _vh;

 
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_set_alpha(alpha * 0.8);
draw_text_transformed(gui_x + 1.5, gui_y + 1.5, texto, escala, escala, 0);

draw_set_color(cor);
draw_set_alpha(alpha);
draw_text_transformed(gui_x, gui_y, texto, escala, escala, 0);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion