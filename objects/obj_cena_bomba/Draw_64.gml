var _L = -300;
var _R = gw + 300;
var _T = -300;
var _B = gh + 300;

#region BORBOLETAS DISTANTES
var _nfr = sprite_get_number(spr_buttercrown);
for (var i = 0; i < array_length(borboletas_fundo); i++) {
    var _b = borboletas_fundo[i];
    var _fr = floor(_b.fase * 0.5) mod _nfr;
    draw_sprite_ext(spr_buttercrown, _fr, _b.x, _b.y, -_b.esc, _b.esc, sin(_b.fase * 0.3) * 10, _b.cor, 0.75);
}
#endregion

#region ESCURIDAO VERMELHA
if (escuro > 0.001) {
    var _pulso = (t >= T_SIRENE && t < T_CLARAO) ? (0.5 + 0.5 * sin(t * 0.08)) * 0.12 : 0;
    draw_set_color(make_color_rgb(45, 0, 0));
    draw_set_alpha(escuro * (1 + _pulso));
    draw_rectangle(_L, _T, _R, _B, false);
}
#endregion

#region AVIOES DISTANTES
if (t >= T_AVIOES && t < T_AVIOES_FIM) {
    for (var i = 0; i < array_length(avioes); i++) {
        var _a = avioes[i];
        var _p = (t - (T_AVIOES + _a.ini)) / _a.dur;
        if (_p < 0 || _p > 1) continue;

        var _margem = 200 * _a.esc;
        var _x = (_a.dir == 1) ? lerp(-_margem, gw + _margem, _p) : lerp(gw + _margem, -_margem, _p);
        var _y = gh * _a.y + sin(t * 0.02 + i) * 3;
        desenhar_aviao(_x, _y, _a.esc, _a.dir, _a.alpha);
    }
}
#endregion

#region CLARAO
if (clarao > 0) {
    draw_set_color(c_white);
    draw_set_alpha(clarao);
    draw_rectangle(_L, _T, _R, _B, false);
}
#endregion

#region BOMBA (pontinho distante)
if (t >= T_BOMBA && t < T_CLARAO) {
    var _p = (t - T_BOMBA) / (T_CLARAO - T_BOMBA);
    var _pe = _p * _p * _p;
    var _bx = BOMBA_X + sin(t * 0.05) * 2 * (1 - _p);
    var _by = lerp(BOMBA_Y_INICIO, BOMBA_Y_FIM, _pe);
    var _r = lerp(2.5, 5, _p);

    #region HOLOFOTE (escurece em volta da bomba)
    if (foco > 0.01) {
        draw_primitive_begin(pr_trianglestrip);
        for (var a = 0; a <= 360; a += 10) {
            draw_vertex_color(_bx + lengthdir_x(110, a),  _by + lengthdir_y(110, a),  c_black, 0);
            draw_vertex_color(_bx + lengthdir_x(1600, a), _by + lengthdir_y(1600, a), c_black, foco);
        }
        draw_primitive_end();
    }
    #endregion

    gpu_set_blendmode(bm_add);

    #region BRILHO AO APARECER
    var _dt = t - T_BOMBA;
    if (_dt < 25) {
        var _s = (1 - _dt / 25) * 18;
        draw_set_color(c_white);
        draw_set_alpha(1 - _dt / 25);
        draw_line_width(_bx - _s, _by, _bx + _s, _by, 2);
        draw_line_width(_bx, _by - _s, _bx, _by + _s, 2);
    }
    #endregion

    #region RASTRO DE FOGO
    var _comp = 20 + 70 * _p;
    draw_primitive_begin(pr_trianglestrip);
    for (var k = 0; k <= 8; k++) {
        var _f = k / 8;
        var _ty = _by - _f * _comp;
        var _w = (1 + _p * 1.5) * (1 - _f * 0.7);
        var _cor = merge_color(make_color_rgb(255, 220, 150), make_color_rgb(255, 50, 0), _f);
        draw_vertex_color(_bx - _w, _ty, _cor, (1 - _f) * 0.7);
        draw_vertex_color(_bx + _w, _ty, _cor, (1 - _f) * 0.7);
    }
    draw_primitive_end();
    #endregion

    #region BRILHO VERMELHO
    draw_set_color(make_color_rgb(255, 60, 30));
    draw_set_alpha(0.3 + 0.3 * _p);
    draw_circle(_bx, _by, _r * 3 * (1 + 0.3 * sin(t * 0.4)), false);
    #endregion

    #region PONTO BRANCO ANTES DO CLARAO
    var _pre = t - (T_CLARAO - 30);
    if (_pre > 0) {
        var _q = _pre / 30;
        draw_set_color(c_white);
        draw_set_alpha(_q);
        draw_circle(_bx, BOMBA_Y_FIM, lerp(0, 200, _q * _q), false);
    }
    #endregion

    gpu_set_blendmode(bm_normal);

    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_circle(_bx, _by, _r, false);
}
#endregion



#region TITULO
if (t >= T_TITULO) {
    var _dt = t - T_TITULO;
    var _a = clamp(min(_dt / 30, (T_FIM - t) / 40), 0, 1);
    var _tr = 3 + (1 - min(1, _dt / 60)) * 8;
    var _esc = 5 + max(0, 1 - _dt / 20) * 3;
    var _tx = gw / 2 + random_range(-_tr, _tr);
    var _ty = gh * 0.42 + random_range(-_tr, _tr);

    draw_set_color(c_black);
    draw_set_alpha(0.45 * _a);
    draw_rectangle(_L, _T, _R, _B, false);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_alpha(_a);
    draw_set_color(c_black);
    draw_text_transformed(_tx + 5, _ty + 5, "APOCALIPSE", _esc, _esc, 0);
    draw_set_color(make_color_rgb(220, 30, 20));
    draw_text_transformed(_tx, _ty, "APOCALIPSE", _esc, _esc, 0);

}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);