#region HUD INTERFACE
if (instance_exists(obj_borboleta) and !instance_exists(obj_loja)) {
    var borboleta = obj_borboleta;
    
    var pos_x = 40;
    var pos_y = 50; 
    var largura_barra = 220;
    var altura_barra = 8;
    
    var percentual_energia = borboleta.energia_atual / borboleta.energia_maxima;
    percentual_energia = clamp(percentual_energia, 0, 1);
    
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_roundrect_ext(pos_x - 2, pos_y - 2, pos_x + largura_barra + 2, pos_y + altura_barra + 2, 4, 4, false);
    
    draw_set_alpha(0.6);
    draw_set_color(make_color_rgb(20, 24, 30));
    draw_roundrect_ext(pos_x, pos_y, pos_x + largura_barra, pos_y + altura_barra, 3, 3, false);
    
    draw_set_alpha(1.0);
    var cor_preenchimento = make_color_rgb(255 * (1 - percentual_energia), 200 + (55 * percentual_energia), 180 * percentual_energia);
	var _critica = (borboleta.energia_atual <= 1 && !borboleta.morto);
    if (_critica && percentual_energia > 0) {
        cor_preenchimento = ((current_time mod 400) < 200) ? make_color_rgb(255, 40, 40) : make_color_rgb(150, 20, 20);
    }
    draw_set_color(cor_preenchimento);
    
    if (percentual_energia > 0) {
	if (_critica) {
        draw_set_color(c_red);
        draw_set_alpha(0.5 + sin(current_time * 0.012) * 0.4);
        draw_roundrect_ext(pos_x - 4, pos_y - 4, pos_x + largura_barra + 4, pos_y + altura_barra + 4, 5, 5, true);
    }
        draw_roundrect_ext(pos_x, pos_y, pos_x + (largura_barra * percentual_energia), pos_y + altura_barra, 3, 3, false);
    }
    
    draw_set_color(c_white);
    draw_set_alpha(0.2);
    for (var i = 1; i < borboleta.energia_maxima; i++) {
        var seg_x = pos_x + (largura_barra / borboleta.energia_maxima) * i;
        draw_line(seg_x, pos_y, seg_x, pos_y + altura_barra - 1);
    }
    
    draw_set_alpha(1.0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // EXIBICAO DE DISTANCIA OU ALERTA DE BOSS
    if (instance_exists(obj_boss)) {
        var _pisca = (current_time % 600 < 300);
        var _cor_alerta = _pisca ? make_color_rgb(255, 60, 60) : make_color_rgb(255, 200, 50);
        var _texto_boss = "⚠";
        
        draw_set_color(c_black);
        draw_text(pos_x + 1, pos_y + 17, _texto_boss);
        
        draw_set_color(_cor_alerta);
        draw_text(pos_x, pos_y + 16, _texto_boss);
    } else {
        var texto_distancia = string(floor(global.distancia_percorrida)) + " m";
        draw_set_color(c_white);
        draw_text(pos_x, pos_y + 16, texto_distancia);
    }
    
    var texto_velocidade = string_format(global.vel_mundo * 10, 0, 0) + " km/h";
    draw_set_color(make_color_rgb(255, 230, 80));
    draw_text(pos_x + largura_barra - string_width(texto_velocidade), pos_y + 16, texto_velocidade);
}
#endregion

#region HUD CAOS COM EFEITOS
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    if (!variable_instance_exists(id, "caos_exibido")) {
        caos_exibido = global.caos;
        caos_escala = 1;
    }

    caos_exibido = lerp(caos_exibido, global.caos, 0.15);

    if (abs(global.caos - caos_exibido) > 0.5) {
        caos_escala = 1.3; 
    }
    caos_escala = lerp(caos_escala, 1, 0.1); 

    var texto_caos = tr("CAOS: ") + string(floor(caos_exibido));
    var caos_x = 40;
    var caos_y = 18;

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_text_transformed(caos_x + 2, caos_y + 2, texto_caos, caos_escala, caos_escala, 0);

    draw_set_alpha(0.3);
    draw_set_color(make_color_rgb(255, 50, 50));
    draw_text_transformed(caos_x - 1, caos_y, texto_caos, caos_escala, caos_escala, 0);
    draw_text_transformed(caos_x + 1, caos_y, texto_caos, caos_escala, caos_escala, 0);
    draw_text_transformed(caos_x, caos_y - 1, texto_caos, caos_escala, caos_escala, 0);
    draw_text_transformed(caos_x, caos_y + 1, texto_caos, caos_escala, caos_escala, 0);

    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 140, 0));
    draw_text_transformed(caos_x, caos_y, texto_caos, caos_escala, caos_escala, 0);
}
#endregion

#region CARDS DE HABILIDADES
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    var _card = 56;
    var _gap = 10;
    var _cy1 = 100;

    for (var s = 0; s < array_length(global.hab_slots); s++) {
        var _i = global.hab_slots[s];
        var _hab = global.habilidades[_i];
        var _cargas = global.hab_cargas[_i];
        var _ativa = habilidade_ativa(_hab.id);
        var _tem = (_cargas > 0);

        var _x1 = 40 + s * (_card + _gap);
        var _x2 = _x1 + _card;
        var _y2 = _cy1 + _card;
        var _mx = (_x1 + _x2) / 2;
        var _my = (_cy1 + _y2) / 2;

        draw_set_color(c_black);
        draw_set_alpha(0.6);
        draw_roundrect_ext(_x1, _cy1, _x2, _y2, 10, 10, false);

        if (_ativa) {
            draw_set_color(_hab.cor);
            draw_set_alpha(0.2 + sin(current_time * 0.02) * 0.1);
            draw_roundrect_ext(_x1, _cy1, _x2, _y2, 10, 10, false);
        }

        draw_set_color(_tem ? _hab.cor : c_dkgray);
        draw_set_alpha(_ativa ? (0.7 + sin(current_time * 0.02) * 0.3) : 0.9);
        draw_roundrect_ext(_x1, _cy1, _x2, _y2, 10, 10, true);

        var _sw = sprite_get_width(_hab.sprite);
        var _sh = sprite_get_height(_hab.sprite);
        var _esc = 34 / max(_sw, _sh);
        var _sx = _mx - (_sw / 2 - sprite_get_xoffset(_hab.sprite)) * _esc;
        var _sy = _my - 2 - (_sh / 2 - sprite_get_yoffset(_hab.sprite)) * _esc;
        draw_sprite_ext(_hab.sprite, 0, _sx, _sy, _esc, _esc, 0, _tem ? c_white : c_gray, _tem ? 1 : 0.4);

        draw_set_color(c_white);
        draw_set_alpha(0.85);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text_transformed(_x1 + 5, _cy1 + 4, string(s + 1), 0.8, 0.8, 0);

        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_text_transformed(_x2 - 5, _y2 - 4, "x" + string(_cargas), 0.8, 0.8, 0);
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion