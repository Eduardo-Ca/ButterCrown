#region CEU
draw_set_alpha(1);
draw_rectangle_color(-600, -300, gw + 600, gh + 300, ceu_topo, ceu_topo, ceu_base, ceu_base, false);

gpu_set_blendmode(bm_add);
if (periodo == "noite") {
    draw_set_color(c_white);
    for (var i = 0; i < qtd_estrelas; i++) {
        var e = estrelas[i];
        draw_set_alpha(0.3 + 0.7 * abs(sin(tempo * 0.05 + e.fase)));
        draw_circle(e.x, e.y, e.tam, false);
    }
} else {
    var _sx = (periodo == "dia") ? gw * 0.8 : gw * 0.75;
    var _sy = (periodo == "dia") ? gh * 0.18 : gh * 0.55;
    var _sc = (periodo == "dia") ? make_color_rgb(255, 230, 140) : make_color_rgb(255, 130, 80);
    draw_set_color(_sc);
    for (var k = 4; k >= 1; k--) {
        draw_set_alpha(0.08);
        draw_circle(_sx, _sy, 40 * (1 + k * 0.6), false);
    }
    draw_set_alpha(0.9);
    draw_circle(_sx, _sy, 40, false);
}
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
#endregion

#region NUVENS
for (var i = 0; i < qtd_nuvens; i++) {
    var n = nuvens[i];
    draw_sprite_ext(spr_nuvem, n.sub, n.x, n.y, n.esc, n.esc, 0, cor_nuvem, 0.8);
}
#endregion

#region BALOES
for (var i = 0; i < qtd_baloes; i++) {
    var b = baloes[i];
    draw_sprite_ext(spr_balao, 0, b.x, b.y, 3, 3, sin(b.osc) * 8, b.cor, 1);
}
#endregion

#region PREDIOS
for (var c = 0; c < array_length(camadas); c++) {
    var _c = camadas[c];
    for (var i = 0; i < array_length(_c.predios); i++) {
        var p = _c.predios[i];
        draw_sprite_ext(spr_predios, p.sub, p.x, _c.cfg.y, _c.cfg.esc * p.flip, _c.cfg.esc, 0, c_white, _c.cfg.alpha);
    }
}
#endregion

#region RASTRO ARCO-IRIS + BORBOLETA
var _n = array_length(rastro);
for (var i = 1; i < _n; i++) {
    var _a = i / _n;
    var _p0 = rastro[i - 1];
    var _p1 = rastro[i];
    draw_set_color(make_color_hsv((tempo * 4 + i * 9) mod 256, 200, 255));
    draw_set_alpha(_a * 0.8);
    draw_line_width(_p0[0], _p0[1], _p1[0], _p1[1], 2 + _a * 8);
}
draw_set_alpha(1);

var _fx = (bor_x - bor_x_ant >= 0) ? 1 : -1;
var _frame = (tempo div 4) mod sprite_get_number(spr_buttercrown_batendo_asas);
var _ang = clamp(-(bor_y - bor_y_ant) * 4, -30, 30) * _fx;
draw_sprite_ext(spr_buttercrown, _frame, bor_x, bor_y, 3 * _fx, 3, _ang, c_white, 1);
#endregion

#region CONFETES
for (var i = 0; i < array_length(confetes); i++) {
    var c = confetes[i];
    draw_set_color(c.cor);
    draw_set_alpha(min(1, c.vida / 20));
    draw_line_width(c.x - lengthdir_x(4, c.rot), c.y - lengthdir_y(4, c.rot),
                    c.x + lengthdir_x(4, c.rot), c.y + lengthdir_y(4, c.rot), 3);
}
draw_set_alpha(1);
#endregion

#region ESCURECER EMBAIXO (leitura dos botoes)
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(-600,     gh * 0.4, c_black, 0);
draw_vertex_color(gw + 600, gh * 0.4, c_black, 0);
draw_vertex_color(-600,     gh + 300, c_black, 0.5);
draw_vertex_color(gw + 600, gh + 300, c_black, 0.5);
draw_primitive_end();
#endregion

#region TITULO
var _sq = titulo_squash;
var _ex = 3 * (1 + _sq * 0.25);
var _ey = 3 * (1 - _sq * 0.25);
var _tx = gw / 2;
var _ty = titulo_y + (titulo_pousou ? sin(tempo * 0.05) * 4 : 0);
var _sub = (tempo div 8) mod sprite_get_number(spr_titulo);

draw_sprite_ext(spr_titulo, _sub, _tx + 6, _ty + 6, _ex, _ey, 0, c_black, 0.35);

gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_titulo, _sub, _tx, _ty, _ex * 1.05, _ey * 1.05, 0, c_yellow, 0.25 + sin(tempo * 0.06) * 0.1);
gpu_set_blendmode(bm_normal);

draw_sprite_ext(spr_titulo, _sub, _tx, _ty, _ex, _ey, 0, c_white, 1);

// estrelinhas girando
if (titulo_pousou) {
    gpu_set_blendmode(bm_add);
    for (var k = 0; k < 6; k++) {
        var _a = tempo * 1.5 + k * 60;
        var _px = _tx + lengthdir_x(320, _a);
        var _py = _ty + lengthdir_y(70, _a);
        desenhar_estrela(_px, _py, 3 + sin(tempo * 0.15 + k) * 1.5, make_color_hsv((k * 40 + tempo) mod 256, 120, 255), 0.9);
    }
    gpu_set_blendmode(bm_normal);
}
draw_set_alpha(1);
#endregion

#region BOTOES
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < qtd_botoes; i++) {
    var _e = botao_esc[i];
    if (_e < 0.02) continue;

    var _b = botoes[i];
    var _sel = (i == sel && !mostrar_controles);
    var _by = botao_y0 + i * botao_esp + (_sel ? sin(tempo * 0.15) * 2 : 0);
    var _w = botao_w * _e / 2;
    var _h = botao_h * _e / 2;
    var _x1 = gw / 2 - _w;
    var _x2 = gw / 2 + _w;

    // sombra
    draw_set_color(c_black);
    draw_set_alpha(0.4);
    draw_roundrect_ext(_x1 + 6, _by - _h + 6, _x2 + 6, _by + _h + 6, 18, 18, false);

    // brilho do selecionado
    if (_sel) {
        gpu_set_blendmode(bm_add);
        draw_set_color(_b.cor);
        draw_set_alpha(0.25 + sin(tempo * 0.1) * 0.1);
        draw_roundrect_ext(_x1 - 10, _by - _h - 10, _x2 + 10, _by + _h + 10, 24, 24, false);
        gpu_set_blendmode(bm_normal);
    }

    // corpo
    draw_set_alpha(0.92);
    draw_set_color(_sel ? _b.cor : make_color_rgb(35, 30, 60));
    draw_roundrect_ext(_x1, _by - _h, _x2, _by + _h, 18, 18, false);

    // faixa de luz
    draw_set_color(c_white);
    draw_set_alpha(_sel ? 0.35 : 0.08);
    draw_roundrect_ext(_x1 + 4, _by - _h + 4, _x2 - 4, _by - 2, 14, 14, false);

    // borda
    draw_set_alpha(1);
    draw_set_color(_sel ? c_white : _b.cor);
    draw_roundrect_ext(_x1, _by - _h, _x2, _by + _h, 18, 18, true);
    draw_roundrect_ext(_x1 + 1, _by - _h + 1, _x2 - 1, _by + _h - 1, 18, 18, true);

    // icone
    var _cor_txt = _sel ? make_color_rgb(40, 20, 50) : c_white;
    var _ix = _x1 + 36 * _e;
    draw_set_color(_cor_txt);
    switch (_b.acao) {
        case "novo":
            draw_text_transformed(_ix, _by, "+", 2 * _e, 2 * _e, 0);
            break;
        case "continuar":
        case "jogar":
            draw_triangle(_ix - 8 * _e, _by - 10 * _e, _ix - 8 * _e, _by + 10 * _e, _ix + 10 * _e, _by, false);
            break;
        case "tutorial":
            draw_text_transformed(_ix, _by, "?", 2 * _e, 2 * _e, 0);
            break;
        case "sair":
            draw_line_width(_ix - 8 * _e, _by - 8 * _e, _ix + 8 * _e, _by + 8 * _e, 3 * _e);
            draw_line_width(_ix + 8 * _e, _by - 8 * _e, _ix - 8 * _e, _by + 8 * _e, 3 * _e);
            break;
    }

    // texto
    if (!_sel) {
        draw_set_color(c_black);
        draw_text_transformed(gw / 2 + 14 * _e + 2, _by + 2, tr(_b.texto), 2 * _e, 2 * _e, 0);
    }
    draw_set_color(_cor_txt);
    draw_text_transformed(gw / 2 + 14 * _e, _by, tr(_b.texto), 2 * _e, 2 * _e, 0);
}
#endregion

#region FAISCAS
gpu_set_blendmode(bm_add);
for (var i = 0; i < array_length(faiscas); i++) {
    var f = faiscas[i];
    draw_set_color(f.cor);
    draw_set_alpha(f.vida / 30);
    draw_circle(f.x, f.y, 2, false);
}
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
#endregion

#region RODAPE
if (global.recorde_distancia > 0) {
    draw_set_color(make_color_hsv((tempo * 2) mod 256, 150, 255));
    draw_text_transformed(gw / 2, gh - 30, tr("RECORDE: ") + string(floor(global.recorde_distancia)) + " m", 1.2, 1.2, 0);
}
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_set_alpha(0.5);
draw_text(gw - 20, gh - 20, "W/S + ENTER");
draw_set_alpha(1);
draw_set_halign(fa_center);
#endregion

#region BOTAO DE IDIOMA
var _lcx = 72;
var _lcy = gh - 36;
var _lw = 56 * idioma_esc;
var _lh = 20 * idioma_esc;
var _en = (tr("JOGAR") == "PLAY");

draw_set_color(c_black);
draw_set_alpha(0.45);
draw_roundrect_ext(_lcx - _lw + 3, _lcy - _lh + 4, _lcx + _lw + 3, _lcy + _lh + 4, 12, 12, false);

draw_set_alpha(0.92);
draw_set_color(make_color_rgb(35, 30, 60));
draw_roundrect_ext(_lcx - _lw, _lcy - _lh, _lcx + _lw, _lcy + _lh, 12, 12, false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(255, 210, 60));
if (_en) draw_roundrect_ext(_lcx + 1, _lcy - _lh + 3, _lcx + _lw - 3, _lcy + _lh - 3, 9, 9, false);
else     draw_roundrect_ext(_lcx - _lw + 3, _lcy - _lh + 3, _lcx - 1, _lcy + _lh - 3, 9, 9, false);

draw_set_color(c_white);
draw_roundrect_ext(_lcx - _lw, _lcy - _lh, _lcx + _lw, _lcy + _lh, 12, 12, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(_en ? c_white : make_color_rgb(40, 20, 50));
draw_text(_lcx - _lw / 2, _lcy, "PT");
draw_set_color(_en ? make_color_rgb(40, 20, 50) : c_white);
draw_text(_lcx + _lw / 2, _lcy, "EN");
#endregion

#region PAINEL DO TUTORIAL
if (painel_escala > 0.01) {
    var _pe = painel_escala;

    // escurece o fundo
    draw_set_color(c_black);
    draw_set_alpha(0.55 * _pe);
    draw_rectangle(-600, -300, gw + 600, gh + 300, false);

    var pw = 780 * _pe;
    var ph = 460 * _pe;
    var px = gw / 2;
    var py = gh / 2;
    var _x1 = px - pw / 2, _y1 = py - ph / 2;
    var _x2 = px + pw / 2, _y2 = py + ph / 2;

    // sombra + corpo em degrade
    draw_set_color(c_black);
    draw_set_alpha(0.45 * _pe);
    draw_roundrect_ext(_x1 + 8, _y1 + 8, _x2 + 8, _y2 + 8, 22, 22, false);

    draw_set_alpha(0.97 * _pe);
    draw_set_color(make_color_rgb(35, 25, 65));
    draw_roundrect_ext(_x1, _y1, _x2, _y2, 22, 22, false);

    // cabecalho
    draw_set_color(make_color_rgb(70, 45, 120));
    draw_roundrect_ext(_x1, _y1, _x2, _y1 + 70 * _pe, 22, 22, false);
    draw_rectangle(_x1, _y1 + 40 * _pe, _x2, _y1 + 70 * _pe, false);

    // borda
    draw_set_alpha(_pe);
    draw_set_color(cor_cyan);
    draw_roundrect_ext(_x1, _y1, _x2, _y2, 22, 22, true);
    draw_roundrect_ext(_x1 + 1, _y1 + 1, _x2 - 1, _y2 - 1, 22, 22, true);

    if (_pe > 0.9) {
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        #region TITULO
        var _ty = _y1 + 36;
        draw_set_color(c_black);
        draw_text_transformed(px + 3, _ty + 3, tr("COMO JOGAR"), 2.2, 2.2, 0);
        draw_set_color(c_yellow);
        draw_text_transformed(px, _ty, tr("COMO JOGAR"), 2.2, 2.2, 0);

        var _bal = sin(tempo * 0.1) * 4;
        draw_sprite_ext(spr_buttercrown, (tempo div 6) mod 3, px - 200, _ty + _bal, 2, 2, 0, c_white, 1);
        draw_sprite_ext(spr_buttercrown, (tempo div 6) mod 3, px + 200, _ty - _bal, -2, 2, 0, c_white, 1);
        #endregion

        // divisoria
        draw_set_color(cor_cyan);
        draw_set_alpha(0.3);
        draw_line_width(px, _y1 + 95, px, _y2 - 85, 2);
        draw_set_alpha(1);

        #region COLUNA ESQUERDA: CONTROLES
        var _lx = px - 340;
        draw_set_color(cor_cyan);
        draw_text_transformed(px - 190, _y1 + 105, tr("CONTROLES"), 1.4, 1.4, 0);

        var _ry = _y1 + 160;
        var _esp = 62;

        draw_set_halign(fa_left);

        desenhar_mouse(_lx + 15, _ry + sin(tempo * 0.08) * 2, -1, c_yellow);
        draw_set_color(c_white);
        draw_set_valign(fa_middle);
        draw_text(_lx + 50, _ry, tr("Voar / dar impulso"));

        _ry += _esp;
        desenhar_mouse(_lx + 15, _ry + sin(tempo * 0.08 + 1) * 2, 1, cor_cyan);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_lx + 50, _ry, tr("Bater asas (vento)"));

        _ry += _esp;
        desenhar_tecla(_lx + 15, _ry, "ESC", 24);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_lx + 50, _ry, tr("Pausar"));

        _ry += _esp;
        desenhar_tecla(_lx + 15, _ry, "1");
        desenhar_tecla(_lx + 50, _ry, "2");
        desenhar_tecla(_lx + 85, _ry, "3");
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_lx + 120, _ry, tr("Usar poderes"));
        #endregion

        #region COLUNA DIREITA: DICAS
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text_transformed(px + 190, _y1 + 105, tr("DICAS"), 1.4, 1.4, 0);

        var _rx = px + 40;
        var _dy = _y1 + 160;
        var _w_txt = 270;

        var _dicas = [
            { spr: spr_balao,        cor: c_lime,   txt: "Pule em balões e pessoas para subir mais alto!" },
            { spr: spr_balao_bomba,  cor: c_red,    txt: "Afaste as bombas com o vento!" },
            { spr: spr_buttercrown,  cor: c_white,  txt: "Cada impulso gasta energia. Use com cuidado!" },
            { spr: spr_estrela,      cor: c_orange, txt: "Cause caos e gaste na loja com upgrades!" }
        ];

        for (var i = 0; i < array_length(_dicas); i++) {
            var _d = _dicas[i];
            var _iy = _dy + i * _esp;
            desenhar_icone(_d.spr, _rx + 16, _iy + sin(tempo * 0.08 + i) * 3, 32);
            draw_set_color(_d.cor);
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_text_ext(_rx + 45, _iy, tr(_d.txt), 18, _w_txt);
        }
        #endregion

        #region BOTAO ENTENDI
        var _bxc = px;
        var _byc = _y2 - 45;
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        var _over = point_in_rectangle(_mx, _my, _bxc - 100, _byc - 25, _bxc + 100, _byc + 25);
        var _eb = _over ? 1.1 : 1 + sin(tempo * 0.1) * 0.03;
        var _bw = 100 * _eb, _bh = 24 * _eb;

        draw_set_color(c_black);
        draw_set_alpha(0.4);
        draw_roundrect_ext(_bxc - _bw + 5, _byc - _bh + 5, _bxc + _bw + 5, _byc + _bh + 5, 16, 16, false);

        draw_set_alpha(1);
        draw_set_color(_over ? c_white : make_color_rgb(90, 220, 110));
        draw_roundrect_ext(_bxc - _bw, _byc - _bh, _bxc + _bw, _byc + _bh, 16, 16, false);
        draw_set_color(c_white);
        draw_set_alpha(0.3);
        draw_roundrect_ext(_bxc - _bw + 4, _byc - _bh + 4, _bxc + _bw - 4, _byc - 2, 12, 12, false);

        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(30, 50, 30));
        draw_text_transformed(_bxc, _byc, tr("ENTENDI!"), 1.6 * _eb, 1.6 * _eb, 0);

        draw_set_color(c_white);
        draw_set_alpha(0.5);
        draw_text(_x2 - 70, _y2 - 20, "ESC");
        draw_set_alpha(1);
        #endregion
    }
}
#endregion

#region CONFIRMAR NOVO JOGO
if (confirmar_novo) {
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(-600, -300, gw + 600, gh + 300, false);

    var _pw = 290;
    var _ph = 130;
    var _pcy = gh / 2;

    draw_set_alpha(0.97);
    draw_set_color(make_color_rgb(35, 25, 65));
    draw_roundrect_ext(gw / 2 - _pw, _pcy - _ph, gw / 2 + _pw, _pcy + _ph, 20, 20, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(255, 90, 100));
    draw_roundrect_ext(gw / 2 - _pw, _pcy - _ph, gw / 2 + _pw, _pcy + _ph, 20, 20, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(gw / 2, _pcy - 78, tr("Começar um novo jogo?"), 1.5, 1.5, 0);
    draw_set_color(make_color_rgb(255, 170, 170));
    draw_text(gw / 2, _pcy - 32, tr("Seu progresso atual será apagado."));

    var _rot = [tr("SIM, APAGAR"), tr("CANCELAR")];
    for (var i = 0; i < 2; i++) {
        var _cx = gw / 2 + ((i == 0) ? -130 : 130);
        var _cy = _pcy + 45;
        var _ativo = (i == confirmar_sel);
        var _cor = (i == 0) ? make_color_rgb(255, 90, 100) : make_color_rgb(80, 220, 255);

        draw_set_color(_ativo ? _cor : make_color_rgb(55, 45, 90));
        draw_roundrect_ext(_cx - 115, _cy - 24, _cx + 115, _cy + 24, 14, 14, false);
        draw_set_color(_ativo ? c_white : _cor);
        draw_roundrect_ext(_cx - 115, _cy - 24, _cx + 115, _cy + 24, 14, 14, true);
        draw_set_color(_ativo ? make_color_rgb(40, 20, 50) : c_white);
        draw_text(_cx, _cy, _rot[i]);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}
#endregion

#region TRANSICAO (circulo fechando)
if (saindo) {
    var _R = point_distance(0, 0, gw, gh);
    var _r = _R * max(0, iris);
    var _cx = gw / 2;
    var _cy = botao_y0;
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_primitive_begin(pr_trianglestrip);
    for (var a = 0; a <= 360; a += 10) {
        draw_vertex(_cx + lengthdir_x(_r, a), _cy + lengthdir_y(_r, a));
        draw_vertex(_cx + lengthdir_x(_R + 50, a), _cy + lengthdir_y(_R + 50, a));
    }
    draw_primitive_end();
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);