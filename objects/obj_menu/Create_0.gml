#region AUDIO
audio_stop_all();
musica = audio_play_sound(snd_musica_tema_1, 10, true);
#endregion

#region BASE
gw = display_get_gui_width();
gh = display_get_gui_height();
tempo = 0;
cor_cyan = make_color_rgb(0, 255, 255);
#endregion

#region CEU (sorteia dia / tarde / noite)
periodo = choose("dia", "tarde", "noite");
switch (periodo) {
    case "dia":   ceu_topo = make_color_rgb(110, 180, 255); ceu_base = make_color_rgb(200, 235, 255); cor_nuvem = c_white; break;
    case "tarde": ceu_topo = make_color_rgb(120, 80, 170);  ceu_base = make_color_rgb(255, 160, 110); cor_nuvem = make_color_rgb(255, 205, 190); break;
    default:      ceu_topo = make_color_rgb(10, 15, 45);    ceu_base = make_color_rgb(60, 45, 110);  cor_nuvem = make_color_rgb(110, 110, 160); break;
}

qtd_estrelas = (periodo == "noite") ? 70 : 0;
estrelas = array_create(qtd_estrelas);
for (var i = 0; i < qtd_estrelas; i++) {
    estrelas[i] = { x: random(gw), y: random(gh * 0.6), tam: random_range(1, 2.5), fase: random(pi * 2) };
}
#endregion

#region NUVENS
qtd_nuvens = 6;
nuvens = array_create(qtd_nuvens);
for (var i = 0; i < qtd_nuvens; i++) {
    nuvens[i] = { x: random(gw + 400) - 200, y: random_range(40, gh * 0.4), esc: random_range(2.5, 4), vel: random_range(0.2, 0.6), sub: irandom(2) };
}
#endregion

#region PREDIOS (3 camadas)
camadas = [];
var _cfg = [
    { esc: 2.2, y: gh - 40, vel: 0.3, sub_min: 7, sub_max: 10, alpha: 0.5 },
    { esc: 2.8, y: gh + 20, vel: 0.6, sub_min: 4, sub_max: 6,  alpha: 0.75 },
    { esc: 3.4, y: gh + 90, vel: 1.0, sub_min: 0, sub_max: 3,  alpha: 1 }
];
for (var c = 0; c < 3; c++) {
    var _k = _cfg[c];
    var _lista = [];
    var _x = -100;
    while (_x < gw + 300) {
        array_push(_lista, { x: _x, sub: irandom_range(_k.sub_min, _k.sub_max), flip: choose(1, -1) });
        _x += random_range(140, 260) * _k.esc / 2.2;
    }
    array_push(camadas, { cfg: _k, predios: _lista, span: _x + 100 });
}
#endregion

#region BALOES
qtd_baloes = 5;
baloes = array_create(qtd_baloes);
for (var i = 0; i < qtd_baloes; i++) {
    baloes[i] = { x: random(gw), y: random_range(gh * 0.3, gh + 200), vel: random_range(0.6, 1.4), osc: random(pi * 2), cor: make_color_hsv(irandom(255), 170, 255) };
}
#endregion

#region BORBOLETA
bor_t = 0;
bor_x = gw / 2;
bor_y = gh / 2;
bor_x_ant = bor_x;
bor_y_ant = bor_y;
rastro = [];
confetes = [];
faiscas = [];
#endregion

#region TITULO
titulo_alvo = gh * 0.2;
titulo_y = -150;
titulo_vy = 0;
titulo_squash = 0;
titulo_pousou = false;
#endregion

#region BOTOES
botoes = [
    { texto: "JOGAR",    acao: "jogar",    cor: make_color_rgb(255, 210, 60) },
    { texto: "TUTORIAL", acao: "tutorial", cor: make_color_rgb(80, 220, 255) },
    { texto: "SAIR",     acao: "sair",     cor: make_color_rgb(255, 90, 100) }
];
qtd_botoes = array_length(botoes);
botao_esc = array_create(qtd_botoes, 0);
botao_y0 = gh * 0.5;
botao_esp = 78;
botao_w = 300;
botao_h = 58;
sel = 0;
mouse_ant_x = 0;
mouse_ant_y = 0;

saindo = false;
iris = 1;
mostrar_controles = false;
painel_escala = 0;
tutorial_abriu = 0;

acionar_botao = function(_i) {
    tocar_som(snd_estrela);
    botao_esc[_i] = 1.4;
    switch (botoes[_i].acao) {
        case "jogar":    saindo = true; break;
        case "tutorial": mostrar_controles = true; tutorial_abriu = tempo; break;
        case "sair":     game_end(); break;
    }
};

desenhar_estrela = function(_x, _y, _t, _cor, _a) {
    draw_set_color(_cor);
    draw_set_alpha(_a);
    draw_triangle(_x - _t, _y, _x + _t, _y, _x, _y - _t * 2.2, false);
    draw_triangle(_x - _t, _y, _x + _t, _y, _x, _y + _t * 2.2, false);
    draw_triangle(_x, _y - _t, _x, _y + _t, _x - _t * 2.2, _y, false);
    draw_triangle(_x, _y - _t, _x, _y + _t, _x + _t * 2.2, _y, false);
};
#endregion

#region DESENHO DO TUTORIAL
desenhar_mouse = function(_x, _y, _lado, _cor) {
    var _w = 13, _h = 18;
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect_ext(_x - _w, _y - _h, _x + _w, _y + _h, 12, 12, false);

    // botao aceso
    draw_set_color(_cor);
    if (_lado == -1) draw_roundrect_ext(_x - _w + 2, _y - _h + 2, _x - 1, _y - 2, 8, 8, false);
    else             draw_roundrect_ext(_x + 1, _y - _h + 2, _x + _w - 2, _y - 2, 8, 8, false);

    draw_set_color(make_color_rgb(40, 30, 60));
    draw_line_width(_x, _y - _h, _x, _y - 2, 2);
    draw_line_width(_x - _w, _y - 2, _x + _w, _y - 2, 2);
    draw_roundrect_ext(_x - _w, _y - _h, _x + _w, _y + _h, 12, 12, true);
};

desenhar_tecla = function(_x, _y, _txt) {
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(120, 120, 150));
    draw_roundrect_ext(_x - 15, _y - 13, _x + 15, _y + 17, 6, 6, false);
    draw_set_color(make_color_rgb(235, 235, 245));
    draw_roundrect_ext(_x - 15, _y - 17, _x + 15, _y + 12, 6, 6, false);
    draw_set_color(make_color_rgb(40, 30, 60));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_x, _y - 2, _txt);
};

desenhar_icone = function(_spr, _x, _y, _tam) {
    var _sw = sprite_get_width(_spr);
    var _sh = sprite_get_height(_spr);
    var _e = _tam / max(_sw, _sh);
    var _dx = _x - (_sw / 2 - sprite_get_xoffset(_spr)) * _e;
    var _dy = _y - (_sh / 2 - sprite_get_yoffset(_spr)) * _e;
    draw_sprite_ext(_spr, 0, _dx, _dy, _e, _e, 0, c_white, 1);
};
#endregion