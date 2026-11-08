#region AVISO DA INVESTIDA
if (estado == "aviso") {
    var _cam_x = camera_get_view_x(view_camera[0]);
    draw_set_color(c_red);
    draw_set_alpha(0.15 + abs(sin(timer * 0.3)) * 0.3);
    draw_rectangle(_cam_x - 10, y - 22, x - 70, y + 25, false);
}
#endregion

draw_set_alpha(1);
if (flash > 0) gpu_set_fog(true, c_white, 0, 0);
draw_self();
gpu_set_fog(false, c_white, 0, 0);


draw_set_color(c_white);