if (eh_boss_secundario) exit;

var _gui_w = display_get_gui_width();
if (_gui_w == 0) _gui_w = room_width;

var _total_vida = 0;
var _total_max_vida = 0;
var _total_vida_exibida = 0;
var _nome = nome_boss;

with (obj_boss) {
    _total_vida += vida;
    _total_max_vida += max_vida;
    _total_vida_exibida += vida_exibida;
}

if (_total_max_vida > 0 && id == instance_find(object_index, 0)) {
    var _bar_w = 400;
    var _bar_h = 20;
    var _bar_x = (_gui_w / 2) - (_bar_w / 2);
    var _bar_y = 35;
    
    var _pct_real = clamp(_total_vida / _total_max_vida, 0, 1);
    var _pct_suave = clamp(_total_vida_exibida / _total_max_vida, 0, 1);
    
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_roundrect_ext(_bar_x - 6, _bar_y - 22, _bar_x + _bar_w + 6, _bar_y + _bar_h + 6, 10, 10, false);
    
    draw_set_color(make_color_rgb(30, 30, 35));
    draw_set_alpha(1.0);
    draw_roundrect_ext(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, 6, 6, false);
    
    if (_pct_suave > 0) {
        draw_set_color(c_white);
        draw_roundrect_ext(_bar_x, _bar_y, _bar_x + (_bar_w * _pct_suave), _bar_y + _bar_h, 6, 6, false);
    }
    
    if (_pct_real > 0) {
        draw_set_color(make_color_rgb(220, 40, 50));
        draw_roundrect_ext(_bar_x, _bar_y, _bar_x + (_bar_w * _pct_real), _bar_y + _bar_h, 6, 6, false);
        
        draw_set_color(make_color_rgb(255, 120, 80));
        draw_roundrect_ext(_bar_x, _bar_y, _bar_x + (_bar_w * _pct_real), _bar_y + (_bar_h / 2), 4, 4, false);
    }
    
    draw_set_color(c_white);
    draw_roundrect_ext(_bar_x - 2, _bar_y - 2, _bar_x + _bar_w + 2, _bar_y + _bar_h + 2, 8, 8, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_black);
    draw_text(_gui_w / 2 + 1, _bar_y - 3, _nome);
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _bar_y - 4, _nome);
    
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _bar_y + (_bar_h / 2), string(ceil(max(0, _total_vida))) + " / " + string(_total_max_vida));
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}