#region VARIAVEIS
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _aba = abas[aba_atual];
var _cor = _aba.cor;
var _a = painel_escala;
var _aa = _a * aba_alpha;
var _oy = (1 - painel_escala) * 30;

var _x1 = painel_x1;
var _y1 = painel_y1 + _oy;
var _x2 = painel_x2;
var _y2 = painel_y2 + _oy;

var _qtd_abas = array_length(abas);
var _tab_w = ((linha_x2 - linha_x1) - tab_gap * (_qtd_abas - 1)) / _qtd_abas;
#endregion

#region FUNDO
draw_set_color(make_color_rgb(6, 8, 20));
draw_set_alpha(0.82 * _a);
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_color(c_white);
for (var i = 0; i < array_length(estrelas_bg); i++) {
    var _e = estrelas_bg[i];
    var _ex = _gw - ((_e.x + timer_loja * _e.v * 25) mod _gw);
    draw_set_alpha(_e.alpha * _a);
    draw_rectangle(_ex, _e.y, _ex + _e.tam, _e.y + _e.tam, false);
}
#endregion

#region PAINEL
draw_set_color(c_black);
draw_set_alpha(0.45 * _a);
draw_roundrect_ext(_x1 + 6, _y1 + 8, _x2 + 6, _y2 + 8, 20, 20, false);

draw_set_color(make_color_rgb(18, 22, 46));
draw_set_alpha(0.97 * _a);
draw_roundrect_ext(_x1, _y1, _x2, _y2, 20, 20, false);

draw_set_color(_cor);
draw_set_alpha(0.9 * _a);
draw_roundrect_ext(_x1, _y1, _x2, _y2, 20, 20, true);
draw_set_alpha(0.3 * _a);
draw_roundrect_ext(_x1 + 4, _y1 + 4, _x2 - 4, _y2 - 4, 17, 17, true);
#endregion

#region CABECALHO
var _ty = _y1 + 36;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(_a);
draw_set_color(c_black);
draw_text_transformed(px + 3, _ty + 3, "LOJA DE UPGRADES", 1.6, 1.6, 0);
draw_set_color(c_white);
draw_text_transformed(px, _ty, "LOJA DE UPGRADES", 1.6, 1.6, 0);

draw_set_halign(fa_left);
draw_set_color(make_color_rgb(140, 150, 185));
draw_text_transformed(_x1 + margem, _ty - 10, "ÚLTIMA: " + string(floor(global.distancia_percorrida)) + " m", 0.8, 0.8, 0);
draw_text_transformed(_x1 + margem, _ty + 10, "RECORDE: " + string(floor(global.recorde_distancia)) + " m", 0.8, 0.8, 0);

if (global.distancia_percorrida > 0 && global.distancia_percorrida >= global.recorde_distancia) {
    draw_set_halign(fa_center);
    draw_set_color(make_color_hsv((current_time / 8) mod 255, 200, 255));
    draw_text_transformed(px, _y1 + 60, "NOVO RECORDE!", 0.8, 0.8, 0);
}

draw_set_halign(fa_right);
var _txt_caos = string(floor(caos_exibido));
var _cor_caos = (flash_caos > 0 && (flash_caos mod 4) < 2) ? c_red : make_color_rgb(255, 170, 40);
var _larg_caos = string_width(_txt_caos) * 1.3;

draw_set_color(make_color_rgb(140, 150, 185));
draw_text_transformed(_x2 - margem, _ty - 14, "CAOS", 0.7, 0.7, 0);
draw_set_color(c_black);
draw_text_transformed(_x2 - margem + 2, _ty + 10, _txt_caos, 1.3, 1.3, 0);
draw_set_color(_cor_caos);
draw_text_transformed(_x2 - margem, _ty + 8, _txt_caos, 1.3, 1.3, 0);

var _cx = _x2 - margem - _larg_caos - 20;
draw_set_color(make_color_rgb(255, 200, 50));
draw_circle(_cx, _ty + 8, 11, false);
draw_set_color(make_color_rgb(200, 130, 20));
draw_circle(_cx, _ty + 8, 11, true);
draw_set_color(make_color_rgb(255, 235, 140));
draw_circle(_cx, _ty + 8, 5, false);
#endregion

#region ABAS
var _tab_y1 = tab_y1 + _oy;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < _qtd_abas; i++) {
    var _tx1 = linha_x1 + i * (_tab_w + tab_gap);
    var _ativa = (i == aba_atual);
    var _hov = (i == hover_aba);
    var _c = abas[i].cor;

    draw_set_color((_ativa || _hov) ? _c : make_color_rgb(40, 46, 80));
    draw_set_alpha(_a * (_ativa ? 0.95 : (_hov ? 0.5 : 0.35)));
    draw_roundrect_ext(_tx1, _tab_y1, _tx1 + _tab_w, _tab_y1 + tab_h, 10, 10, false);

    draw_set_color(_c);
    draw_set_alpha(_a * (_ativa ? 1 : 0.5));
    draw_roundrect_ext(_tx1, _tab_y1, _tx1 + _tab_w, _tab_y1 + tab_h, 10, 10, true);

    draw_set_color(_ativa ? c_black : make_color_rgb(200, 205, 230));
    draw_set_alpha(_a);
    draw_text(_tx1 + _tab_w / 2, _tab_y1 + tab_h / 2, abas[i].nome);
}
#endregion

#region ITENS
var _lista = _aba.upgrades;
var _total = array_length(_lista);
var _qtd_vis = min(_total, max_visiveis);

for (var j = 0; j < _qtd_vis; j++) {
    var _idx = rolagem + j;
    var _upg = _lista[_idx];
    var _lvl = variable_global_get(_upg.nivel_global);
    var _max = (_lvl >= _upg.max_lvl);
    var _preco = _upg.preco_base + (_lvl * _upg.esc);
    var _pode = (global.caos >= _preco);

    var _dx = ((shake_row[_idx] > 0) ? sin(shake_row[_idx] * 1.8) * 5 : 0) + (1 - aba_alpha) * 30;
    var _rx1 = linha_x1 + _dx;
    var _rx2 = linha_x2 + _dx;
    var _ry1 = linhas_y1 + j * (linha_h + linha_gap) + _oy;
    var _ry2 = _ry1 + linha_h;

    #region CARTAO
    draw_set_color((hover_item == j) ? make_color_rgb(36, 44, 84) : make_color_rgb(26, 32, 62));
    draw_set_alpha(0.95 * _aa);
    draw_roundrect_ext(_rx1, _ry1, _rx2, _ry2, 10, 10, false);

    if (flash_row[_idx] > 0) {
        draw_set_color(_cor);
        draw_set_alpha(_aa * (flash_row[_idx] / 20) * 0.6);
        draw_roundrect_ext(_rx1, _ry1, _rx2, _ry2, 10, 10, false);
    }

    draw_set_color(_cor);
    draw_set_alpha(_aa);
    draw_roundrect_ext(_rx1, _ry1, _rx1 + 6, _ry2, 3, 3, false);
    #endregion

    #region TEXTOS
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_set_alpha(_aa);
    draw_set_color(c_white);
    draw_text(_rx1 + 20, _ry1 + 12, _upg.nome);

    draw_set_color(make_color_rgb(140, 150, 185));
    draw_text_transformed(_rx1 + 20, _ry1 + 36, _upg.desc, 0.8, 0.8, 0);
    #endregion

    #region BARRAS DE NIVEL
    var _pw = 16;
    var _pg = 6;
    var _px0 = _rx1 + 390;
    var _py0 = _ry1 + (linha_h - 22) / 2;

    for (var b = 0; b < _upg.max_lvl; b++) {
        var _pxx = _px0 + b * (_pw + _pg);

        if (b < _lvl) {
            draw_set_color(_cor);
            draw_set_alpha(_aa);
            draw_roundrect_ext(_pxx, _py0, _pxx + _pw, _py0 + 22, 4, 4, false);

            draw_set_color(c_white);
            draw_set_alpha(_aa * 0.35);
            draw_rectangle(_pxx + 3, _py0 + 3, _pxx + _pw - 3, _py0 + 7, false);
        } else {
            draw_set_color(make_color_rgb(70, 78, 120));
            draw_set_alpha(_aa * 0.9);
            draw_roundrect_ext(_pxx, _py0, _pxx + _pw, _py0 + 22, 4, 4, true);
        }
    }
    #endregion

    #region VALORES
    draw_set_valign(fa_middle);
    var _meio = _ry1 + linha_h / 2;

    if (_max) {
        draw_set_color(make_color_rgb(255, 210, 70));
        draw_set_alpha(_aa);
        draw_text_transformed(_rx1 + 640, _meio, _upg.valor(_lvl), 0.8, 0.8, 0);
    } else {
        draw_set_color(make_color_rgb(140, 150, 185));
        draw_set_alpha(_aa);
        draw_text_transformed(_rx1 + 640, _meio - 9, _upg.valor(_lvl), 0.8, 0.8, 0);
        draw_set_color(make_color_rgb(120, 255, 150));
        draw_text_transformed(_rx1 + 640, _meio + 9, "> " + _upg.valor(_lvl + 1), 0.8, 0.8, 0);
    }
    #endregion

    #region BOTAO DE COMPRA
    var _bx1 = _rx2 - 120;
    var _bx2 = _rx2 - 16;
    var _by1 = _ry1 + (linha_h - 38) / 2;
    var _by2 = _by1 + 38;
    var _hb = (hover_botao == j);
    var _g = _hb ? 2 : 0;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    if (_max) {
        draw_set_color(make_color_rgb(235, 185, 45));
        draw_set_alpha(_aa);
        draw_roundrect_ext(_bx1, _by1, _bx2, _by2, 8, 8, false);
        draw_set_color(c_black);
        draw_text((_bx1 + _bx2) / 2, (_by1 + _by2) / 2, "MÁX");
    } else if (_pode) {
        draw_set_color(_hb ? make_color_rgb(110, 255, 140) : make_color_rgb(50, 200, 100));
        draw_set_alpha(_aa);
        draw_roundrect_ext(_bx1 - _g, _by1 - _g, _bx2 + _g, _by2 + _g, 8, 8, false);
        draw_set_color(c_black);
        draw_text((_bx1 + _bx2) / 2, (_by1 + _by2) / 2, string(_preco) + " C");
    } else {
        draw_set_color(make_color_rgb(80, 28, 40));
        draw_set_alpha(_aa);
        draw_roundrect_ext(_bx1, _by1, _bx2, _by2, 8, 8, false);
        draw_set_color(make_color_rgb(200, 70, 80));
        draw_roundrect_ext(_bx1, _by1, _bx2, _by2, 8, 8, true);
        draw_set_color(make_color_rgb(255, 130, 130));
        draw_text((_bx1 + _bx2) / 2, (_by1 + _by2) / 2, string(_preco) + " C");
    }
    #endregion
}

#region BARRA DE ROLAGEM
if (_total > max_visiveis) {
    var _tr_x1 = linha_x2 + 10;
    var _tr_x2 = _tr_x1 + 6;
    var _tr_y1 = linhas_y1 + _oy;
    var _tr_y2 = _tr_y1 + max_visiveis * (linha_h + linha_gap) - linha_gap;
    var _tr_h = _tr_y2 - _tr_y1;

    var _th = max(30, _tr_h * (max_visiveis / _total));
    var _frac = rolagem / (_total - max_visiveis);
    var _ty1 = _tr_y1 + (_tr_h - _th) * _frac;

    draw_set_color(make_color_rgb(40, 46, 80));
    draw_set_alpha(_a * 0.8);
    draw_roundrect_ext(_tr_x1, _tr_y1, _tr_x2, _tr_y2, 3, 3, false);

    draw_set_color(_cor);
    draw_set_alpha(_a);
    draw_roundrect_ext(_tr_x1, _ty1, _tr_x2, _ty1 + _th, 3, 3, false);
}
#endregion

#region ABA VAZIA
if (_total == 0) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(_aa);
    draw_set_color(make_color_rgb(140, 150, 185));
    draw_text_transformed(px, linhas_y1 + _oy + 130, "EM BREVE", 1.4, 1.4, 0);
    draw_text_transformed(px, linhas_y1 + _oy + 165, "Novas habilidades chegando", 0.8, 0.8, 0);
}
#endregion
#endregion

#region BOTAO JOGAR
var _jy1 = jogar_y1 + _oy;
var _jy2 = jogar_y2 + _oy;
var _gj = hover_jogar ? 4 : 0;
var _pulso = sin(timer_loja * 3) * 0.5 + 0.5;
var _cor_jogar = merge_color(make_color_rgb(40, 190, 110), make_color_rgb(80, 235, 150), hover_jogar ? 1 : _pulso * 0.6);

draw_set_alpha(_a);
draw_set_color(_cor_jogar);
draw_roundrect_ext(jogar_x1 - _gj, _jy1 - _gj, jogar_x2 + _gj, _jy2 + _gj, 14, 14, false);

draw_set_color(c_white);
draw_set_alpha(_a * 0.6);
draw_roundrect_ext(jogar_x1 - _gj, _jy1 - _gj, jogar_x2 + _gj, _jy2 + _gj, 14, 14, true);

draw_set_alpha(_a);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text_transformed(px, (_jy1 + _jy2) / 2, "JOGAR NOVAMENTE", 1.1, 1.1, 0);

draw_set_color(make_color_rgb(140, 150, 185));
draw_set_halign(fa_left);
var _hint = (array_length(_aba.upgrades) > max_visiveis) ? "Q / E ABA   RODA: ROLAR" : "Q / E  TROCAR ABA";
draw_text_transformed(linha_x1, (_jy1 + _jy2) / 2, _hint, 0.8, 0.8, 0);
draw_set_halign(fa_right);
draw_text_transformed(linha_x2, (_jy1 + _jy2) / 2, "ENTER  JOGAR", 0.8, 0.8, 0);
#endregion

#region RESET
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion