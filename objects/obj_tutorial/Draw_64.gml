#region DESENHO DA CONTAGEM
if (em_intro) {
    var _ix = display_get_gui_width() / 2;
    var _iy = display_get_gui_height() * 0.35;

    var _itexto = (etapa_intro > 0) ? string(etapa_intro) : tr("VOAR!");
    var _total = (etapa_intro > 0) ? frames_por_numero : 25;
    var _t = 1 - (timer_intro / _total);
    var _iesc = (etapa_intro > 0) ? (4 - _t * 1.5) : (3 + _t * 1.5);
    var _ialpha = (etapa_intro > 0) ? 1 : (1 - _t);
    var _icor = (etapa_intro > 0) ? c_white : c_lime;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_alpha(_ialpha);
    draw_set_color(c_black);
    draw_text_transformed(_ix + 3, _iy + 3, _itexto, _iesc, _iesc, 0);
    draw_set_color(_icor);
    draw_text_transformed(_ix, _iy, _itexto, _iesc, _iesc, 0);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}
#endregion

#region TRAVAS
if (global.tutorial_concluido) exit;
if (global.pausado || instance_exists(obj_loja) || instance_exists(obj_boss)) exit;
#endregion

#region DESENHO DA DICA
var _alvo = (visivel && passo < array_length(textos)) ? 1 : 0;
alpha = lerp(alpha, _alvo, 0.1);
if (alpha < 0.02) exit;

var _x = display_get_gui_width() / 2;
var _y = display_get_gui_height() - 70 + (1 - alpha) * 10;

var _texto = (timer_feedback > 0) ? tr("BOA!") : textos[passo];
var _cor = (timer_feedback > 0) ? c_lime : c_white;
var _esc = 1.1 + sin(current_time * 0.005) * 0.02;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _w = string_width(_texto) * _esc + 32;
var _h = string_height(_texto) * _esc + 16;

draw_set_color(c_black);
draw_set_alpha(alpha * 0.55);
draw_roundrect_ext(_x - _w / 2, _y - _h / 2, _x + _w / 2, _y + _h / 2, 10, 10, false);

draw_set_alpha(alpha);
draw_set_color(c_black);
draw_text_transformed(_x + 2, _y + 2, _texto, _esc, _esc, 0);
draw_set_color(_cor);
draw_text_transformed(_x, _y, _texto, _esc, _esc, 0);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion