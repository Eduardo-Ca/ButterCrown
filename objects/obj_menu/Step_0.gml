tempo++;
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

#region FUNDO: NUVENS, PREDIOS, BALOES
for (var i = 0; i < qtd_nuvens; i++) {
    var n = nuvens[i];
    n.x -= n.vel;
    if (n.x < -300) { n.x = gw + 300; n.y = random_range(40, gh * 0.4); }
}

for (var c = 0; c < array_length(camadas); c++) {
    var _c = camadas[c];
    for (var i = 0; i < array_length(_c.predios); i++) {
        var p = _c.predios[i];
        p.x -= _c.cfg.vel;
        if (p.x < -250) {
            p.x += _c.span;
            p.sub = irandom_range(_c.cfg.sub_min, _c.cfg.sub_max);
        }
    }
}

for (var i = 0; i < qtd_baloes; i++) {
    var b = baloes[i];
    b.y -= b.vel;
    b.osc += 0.03;
    b.x += sin(b.osc) * 0.5;
    if (b.y < -100) { b.y = gh + 80; b.x = random(gw); b.cor = make_color_hsv(irandom(255), 170, 255); }
}
#endregion

#region BORBOLETA
bor_x_ant = bor_x;
bor_y_ant = bor_y;
if (!saindo) {
    bor_t += 0.008;
    bor_x = gw * 0.5 + cos(bor_t) * gw * 0.38;
    bor_y = gh * 0.5 + sin(bor_t * 2) * gh * 0.2;
} else {
    bor_x += 14;
    bor_y = lerp(bor_y, gh * 0.5, 0.1);
}
array_push(rastro, [bor_x, bor_y]);
if (array_length(rastro) > 28) array_delete(rastro, 0, 1);

// estoura baloes
for (var i = 0; i < qtd_baloes; i++) {
    var b = baloes[i];
    if (point_distance(b.x, b.y, bor_x, bor_y) < 40) {
        repeat (20) {
            array_push(confetes, { x: b.x, y: b.y, vx: random_range(-5, 5), vy: random_range(-7, -1),
                cor: make_color_hsv(irandom(255), 200, 255), rot: random(360), vrot: random_range(-15, 15), vida: 60 });
        }
        tocar_som(snd_bolha);
        b.y = gh + 100;
        b.x = random(gw);
    }
}
#endregion

#region CONFETES E FAISCAS
for (var i = array_length(confetes) - 1; i >= 0; i--) {
    var c = confetes[i];
    c.vy += 0.2;
    c.x += c.vx;
    c.y += c.vy;
    c.rot += c.vrot;
    c.vida--;
    if (c.vida <= 0) array_delete(confetes, i, 1);
}
for (var i = array_length(faiscas) - 1; i >= 0; i--) {
    var f = faiscas[i];
    f.x += f.vx;
    f.y += f.vy;
    f.vida--;
    if (f.vida <= 0) array_delete(faiscas, i, 1);
}
#endregion

#region TITULO (cai e quica)
if (!titulo_pousou) {
    titulo_vy += 1.1;
    titulo_y += titulo_vy;
    if (titulo_y >= titulo_alvo) {
        titulo_y = titulo_alvo;
        if (titulo_vy > 4) {
            titulo_vy = -titulo_vy * 0.45;
            titulo_squash = 1;
            tocar_som(snd_pulo);
        } else {
            titulo_vy = 0;
            titulo_pousou = true;
        }
    }
}
titulo_squash = lerp(titulo_squash, 0, 0.15);
#endregion
#region BOTAO DE IDIOMA
var _lang_over = point_in_rectangle(mx, my, 16, gh - 56, 128, gh - 16);
idioma_esc = lerp(idioma_esc, _lang_over ? 1.1 : 1, 0.2);

if (!mostrar_controles && !saindo && !confirmar_novo) {
    if ((_lang_over && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(ord("L"))) {
        idioma_alternar();
        tocar_som(snd_estrela);
    }
}
#endregion
#region CONFIRMAR NOVO JOGO
if (confirmar_novo && tempo > confirmar_abriu + 1) {
    var _cy = gh / 2 + 45;
    var _cover = -1;

    for (var i = 0; i < 2; i++) {
        var _cx = gw / 2 + ((i == 0) ? -130 : 130);
        if (point_in_rectangle(mx, my, _cx - 115, _cy - 24, _cx + 115, _cy + 24)) _cover = i;
    }

    if ((mx != mouse_ant_x || my != mouse_ant_y) && _cover != -1 && _cover != confirmar_sel) {
        confirmar_sel = _cover;
        tocar_som(snd_golpe);
    }
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        confirmar_sel = 1 - confirmar_sel;
        tocar_som(snd_golpe);
    }

    if (keyboard_check_pressed(vk_escape)) {
        confirmar_novo = false;
        tocar_som(snd_golpe);
    } else if ((_cover != -1 && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(vk_enter)) {
        if (_cover != -1 && mouse_check_button_pressed(mb_left)) confirmar_sel = _cover;
        tocar_som(snd_estrela);
        confirmar_novo = false;
        if (confirmar_sel == 0) {
            apagar_progresso();
            saindo = true;
        }
    }
}
#endregion

#region BOTOES
if (!mostrar_controles && !saindo && !confirmar_novo) {
    var _mexeu = (mx != mouse_ant_x || my != mouse_ant_y);
    var _hover = -1;
    for (var i = 0; i < qtd_botoes; i++) {
        var _by = botao_y0 + i * botao_esp;
        if (point_in_rectangle(mx, my, gw / 2 - botao_w / 2, _by - botao_h / 2, gw / 2 + botao_w / 2, _by + botao_h / 2)) _hover = i;
    }

    if (_mexeu && _hover != -1 && _hover != sel) { sel = _hover; tocar_som(snd_golpe); }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        sel = (sel - 1 + qtd_botoes) mod qtd_botoes;
        tocar_som(snd_golpe);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        sel = (sel + 1) mod qtd_botoes;
        tocar_som(snd_golpe);
    }

    if (mouse_check_button_pressed(mb_left) && _hover != -1) {
        sel = _hover;
        acionar_botao(sel);
    } else if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        acionar_botao(sel);
    }
}
mouse_ant_x = mx;
mouse_ant_y = my;

for (var i = 0; i < qtd_botoes; i++) {
    if (tempo < 45 + i * 8) continue; // aparecem depois do titulo
    var _alvo = (i == sel && !mostrar_controles) ? 1.15 : 1;
    if (i == 0 && sel != 0) _alvo += sin(tempo * 0.08) * 0.04;
    botao_esc[i] = lerp(botao_esc[i], _alvo, 0.2);
}

// faiscas no botao selecionado
if (!mostrar_controles && tempo mod 4 == 0 && botao_esc[sel] > 0.5) {
    var _by = botao_y0 + sel * botao_esp;
    array_push(faiscas, {
        x: gw / 2 + random_range(-botao_w / 2, botao_w / 2),
        y: _by + choose(-1, 1) * botao_h / 2,
        vx: random_range(-0.5, 0.5),
        vy: random_range(-1.5, -0.5),
        vida: 30,
        cor: botoes[sel].cor
    });
}
#endregion

#region PAINEL DO TUTORIAL
if (mostrar_controles && tempo > tutorial_abriu + 1) {
    var _bx = gw / 2;
    var _byb = gh / 2 + 230 - 45;
    var _over = point_in_rectangle(mx, my, _bx - 100, _byb - 25, _bx + 100, _byb + 25);

    if ((_over && mouse_check_button_pressed(mb_left))
        || keyboard_check_pressed(vk_escape)
        || keyboard_check_pressed(vk_enter)) {
        mostrar_controles = false;
        tocar_som(snd_golpe);
    }
}
painel_escala = lerp(painel_escala, mostrar_controles ? 1.0 : 0.0, 0.25);
#endregion

#region TRANSICAO PRO JOGO
if (saindo) {
    iris -= 0.025;
    audio_sound_gain(musica, max(0, iris), 0);
    if (iris <= 0) {
        audio_stop_sound(musica);
        room_goto(jogo);
    }
}
#endregion