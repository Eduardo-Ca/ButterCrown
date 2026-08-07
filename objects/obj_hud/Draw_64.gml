
#region HUD INTERFACE
if (instance_exists(obj_borboleta)) {
    var borboleta = obj_borboleta;
    
    var pos_x = 40;
    var pos_y = 50; 
    var largura_barra = 160;
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
    draw_set_color(cor_preenchimento);
    
    if (percentual_energia > 0) {
        draw_roundrect_ext(pos_x, pos_y, pos_x + (largura_barra * percentual_energia), pos_y + altura_barra, 3, 3, false);
    }
    
    draw_set_color(c_white);
    draw_set_alpha(0.2);
    for (var i = 1; i < borboleta.energia_maxima; i++) {
        var seg_x = pos_x + (largura_barra / borboleta.energia_maxima) * i;
        draw_line(seg_x, pos_y, seg_x, pos_y + altura_barra - 1);
    }
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var texto_distancia = string(floor(global.distancia_percorrida)) + " m";
    draw_text(pos_x, pos_y + 16, texto_distancia);
    
    var texto_velocidade = string_format(global.vel_mundo * 10, 0, 0) + " km/h";
    draw_set_color(make_color_rgb(255, 230, 80));
    draw_text(pos_x + largura_barra - string_width(texto_velocidade), pos_y + 16, texto_velocidade);
}
#endregion

#region HUD CAOS COM EFEITOS
if(!obj_borboleta.morto){
	if (!variable_instance_exists(id, "caos_exibido")) {
	    caos_exibido = global.caos;
	    caos_escala = 1;
	}

	caos_exibido = lerp(caos_exibido, global.caos, 0.15);

	if (abs(global.caos - caos_exibido) > 0.5) {
	    caos_escala = 1.3; 
	}
	caos_escala = lerp(caos_escala, 1, 0.1); 

	var texto_caos = "CAOS: " + string(floor(caos_exibido));
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