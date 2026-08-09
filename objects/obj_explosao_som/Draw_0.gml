#region DESENHO DA ONDA SONORA PROCEDURAL
if (alpha <= 0) exit;

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

gpu_set_blendmode(bm_add);

draw_primitive_begin(pr_linestrip);
for (var i = 0; i <= distorcao_pontos; i++) {
    var _idx = i % distorcao_pontos;
    var _ang = (360 / distorcao_pontos) * i;
    var _r = raio + offset_ondas[_idx];
    
    var _px = x + lengthdir_x(_r, _ang);
    var _py = y + lengthdir_y(_r, _ang);
    
    draw_vertex_color(_px, _py,c_aqua, alpha);
}
draw_primitive_end();

draw_primitive_begin(pr_linestrip);
for (var i = 0; i <= distorcao_pontos; i++) {
    var _idx = i % distorcao_pontos;
    var _ang = (360 / distorcao_pontos) * i;
    var _r = (raio * 0.75) + (offset_ondas[_idx] * 0.5);
    
    var _px = x + lengthdir_x(_r, _ang);
    var _py = y + lengthdir_y(_r, _ang);
    
    draw_vertex_color(_px, _py, c_orange, alpha * 0.8);
}
draw_primitive_end();

draw_set_alpha(alpha * 0.15);
draw_set_color(c_white);
draw_circle(x, y, raio * 1.1, false);

gpu_set_blendmode(bm_normal);
draw_set_alpha(1.0);
#endregion