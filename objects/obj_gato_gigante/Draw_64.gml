event_inherited();

#region CORACOES DO GATO
var _gw = display_get_gui_width();
var _spr = spr_coracao;
var _sc = 32 / sprite_get_height(_spr);
var _sw = sprite_get_width(_spr);
var _sh = sprite_get_height(_spr);
var _ox = sprite_get_xoffset(_spr);
var _oy = sprite_get_yoffset(_spr);

var _esp = 44;
var _x0 = _gw / 2 - (coracoes_max - 1) * _esp / 2;
var _y0 = 88;

for (var i = 0; i < coracoes_max; i++) {
    var _hx = _x0 + i * _esp;
    var _hy = _y0;

    // vazio (sombra escura)
    draw_sprite_ext(_spr, 0, _hx, _hy, _sc, _sc, 0, c_black, 0.5);

    if (i < vida_real) {
        var _esc = (vida_real == 1) ? 1 + abs(sin(current_time * 0.012)) * 0.25 : 1;
        var _tx = (treme_coracao > 0) ? random_range(-3, 3) : 0;
        var _ty = (treme_coracao > 0) ? random_range(-3, 3) : 0;
        draw_sprite_ext(_spr, 0, _hx + _tx, _hy + _ty, _sc * _esc, _sc * _esc, 0, c_white, 1);
    } else {
        // quebrando: as duas metades se afastam
        var _q = coracao_quebra[i];
        if (_q > 0 && _q < 1) {
            var _off = _q * 22;
            var _dy = _hy - _oy * _sc + _off * 0.6;
            draw_sprite_part_ext(_spr, 0, 0, 0, _sw / 2, _sh,
                _hx - _ox * _sc - _off, _dy, _sc, _sc, c_white, 1 - _q);
            draw_sprite_part_ext(_spr, 0, _sw / 2, 0, _sw / 2, _sh,
                _hx - _ox * _sc + (_sw / 2) * _sc + _off, _dy, _sc, _sc, c_white, 1 - _q);
        }
    }
}
draw_set_alpha(1);
#endregion

#region AVISO DE ONDA
if (onda_banner > 0 && timer_aviso <= 0) {
    var _a = min(1, onda_banner / 20, (90 - onda_banner) / 10);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(_a);
    draw_set_color(c_black);
    draw_text_transformed(_gw / 2 + 2, 132, "ONDA " + string(onda), 1.6, 1.6, 0);
    draw_set_color(make_color_rgb(255, 120, 200));
    draw_text_transformed(_gw / 2, 130, "ONDA " + string(onda), 1.6, 1.6, 0);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion

#region AVISO DO CHEFE
if (timer_aviso > 0 && vida_real > 0 && !morto) {
    var _prog = 1 - (timer_aviso / timer_aviso_max);
    var _alpha = min(1, _prog * 8, timer_aviso / 30);
    var _pulso = 1 + sin(current_time * 0.012) * 0.04;
    var _cx = _gw / 2;
    var _cy = 140;
    var _larg = string_width(texto_aviso) * 2 * _pulso;
    var _alt = 20 * 2 * _pulso;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_black);
    draw_set_alpha(0.65 * _alpha);
    draw_roundrect_ext(_cx - _larg / 2 - 24, _cy - _alt / 2 - 10, _cx + _larg / 2 + 24, _cy + _alt / 2 + 10, 12, 12, false);

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