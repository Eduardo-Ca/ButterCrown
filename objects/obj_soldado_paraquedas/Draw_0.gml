var _spr = spr_soldado_paraquedas;
var _w = sprite_get_width(_spr);
var _h = sprite_get_height(_spr);
var _ox = sprite_get_xoffset(_spr);
var _oy = sprite_get_yoffset(_spr);
var _h_soldado = _h - CORTE_SOLDADO;

#region SOLDADO
if (assustado) {
    if (!soldado_sumiu) {
        var _tlx = x - lengthdir_x(_w / 2, rot_queda) - lengthdir_x(_h_soldado / 2, rot_queda - 90);
        var _tly = y - lengthdir_y(_w / 2, rot_queda) - lengthdir_y(_h_soldado / 2, rot_queda - 90);
        draw_sprite_general(_spr, 0, 0, CORTE_SOLDADO, _w, _h_soldado, _tlx, _tly, 1, 1, rot_queda, c_white, c_white, c_white, c_white, 1);
    }
} else if (pousou) {
    if (alpha_para > 0.01) {
        draw_sprite_part_ext(_spr, 0, 0, 0, _w, CORTE_SOLDADO, x - _ox, y - _oy + CORTE_SOLDADO * (1 - alpha_para), 1, alpha_para, c_white, alpha_para);
    }
    draw_sprite_part_ext(_spr, 0, 0, CORTE_SOLDADO, _w, _h_soldado, x - _ox, y - _oy + CORTE_SOLDADO, 1, 1, c_white, 1);
} else {
    var _cx = x + lengthdir_x(_oy, 270 + ang_balanco);
    var _cy = (y - _oy) + lengthdir_y(_oy, 270 + ang_balanco);
    draw_sprite_ext(_spr, 0, _cx, _cy, 1, 1, ang_balanco, c_white, 1);
}
#endregion

#region PARAQUEDAS SOLTO
if (para_alpha > 0) {
    var _xs = 0.75 + sin(para_t * 0.25) * 0.25;
    var _ys = max(0.35, 1 - para_t * 0.012);
    var _rot = sin(para_t * 0.12) * 25;
    var _px = para_x - lengthdir_x(_w * _xs / 2, _rot) - lengthdir_x(CORTE_SOLDADO * _ys / 2, _rot - 90);
    var _py = para_y - lengthdir_y(_w * _xs / 2, _rot) - lengthdir_y(CORTE_SOLDADO * _ys / 2, _rot - 90);
    draw_sprite_general(_spr, 0, 0, 0, _w, CORTE_SOLDADO, _px, _py, _xs, _ys, _rot, c_white, c_white, c_white, c_white, para_alpha);
}
#endregion