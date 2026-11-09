

#region DESENHAR MENU DE PAUSA
if (global.pausado && !(instance_exists(obj_tutorial) && obj_tutorial.em_intro)) {
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();

    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // sombra + titulo
    draw_set_color(c_black);
    draw_text_transformed(_gw / 2 + 3, _gh / 2 - 107, tr("JOGO PAUSADO"), 2.5, 2.5, 0);
    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _gh / 2 - 110, tr("JOGO PAUSADO"), 2.5, 2.5, 0);

    // piscando
    draw_set_alpha(0.6 + sin(current_time * 0.005) * 0.4);
    draw_text(_gw / 2, _gh / 2 - 62, tr("Pressione ESC para Voltar"));

    // botoes
    for (var i = 0; i < 2; i++) {
        var _sel = (i == pausa_sel);
        var _by = pausa_y(i);
        var _w = pausa_w * pausa_esc[i] / 2;
        var _h = pausa_h * pausa_esc[i] / 2;
        var _cor = (i == 0) ? make_color_rgb(255, 210, 60) : make_color_rgb(80, 220, 255);

        draw_set_color(c_black);
        draw_set_alpha(0.4);
        draw_roundrect_ext(_gw / 2 - _w + 5, _by - _h + 5, _gw / 2 + _w + 5, _by + _h + 5, 18, 18, false);

        draw_set_alpha(0.95);
        draw_set_color(_sel ? _cor : make_color_rgb(35, 30, 60));
        draw_roundrect_ext(_gw / 2 - _w, _by - _h, _gw / 2 + _w, _by + _h, 18, 18, false);

        draw_set_alpha(1);
        draw_set_color(_sel ? c_white : _cor);
        draw_roundrect_ext(_gw / 2 - _w, _by - _h, _gw / 2 + _w, _by + _h, 18, 18, true);

        draw_set_color(_sel ? make_color_rgb(40, 20, 50) : c_white);
        draw_text_transformed(_gw / 2, _by, tr(pausa_opcoes[i]), 1.5 * pausa_esc[i], 1.5 * pausa_esc[i], 0);
    }

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion

#region DRAW LOGS PAUSA
if (global.pausado && !(instance_exists(obj_tutorial) && obj_tutorial.em_intro)) {
    var gui_h = display_get_gui_height();
    
    var start_x = 40;
    var start_y = gui_h - 60;
    var espacamento = 24;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    var total = array_length(global.logs_eventos);
    
    if (total > 0) {
        draw_set_color(c_yellow);
        draw_text(start_x, start_y - (total * espacamento) - 10, tr("--- REAÇÕES EM CADEIA ---"));
        
        for (var i = 0; i < total; i++) {
            var item = global.logs_eventos[i];
            var log_y = start_y - (i * espacamento);
            
            var alpha = clamp(item.timer / 60, 0.2, 1.0);
            
            draw_set_color(c_black);
            draw_set_alpha(alpha);
            draw_text(start_x + 2, log_y + 2, item.texto);
            
            draw_set_color(c_white);
            draw_text(start_x, log_y, item.texto);
        }
    }
    
    draw_set_alpha(1.0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion

#region RECORDE 
if(!instance_exists(obj_loja) || global.distancia_percorrida < global.recorde_distancia){
	exit;
}
var _pos_x = display_get_gui_width() / 2;
var _pos_y = 30;

var _escala = 1.1 + sin(current_time * 0.004) * 0.08;
var _angulo = sin(current_time * 0.002) * 2;
var _cor_arcoiris = make_color_hsv((current_time / 12) % 255, 255, 255);

var _texto = tr("RECORDE: ") + string(floor(global.recorde_distancia)) + "m";

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed_color(
    _pos_x + 2, _pos_y + 2, _texto, 
    _escala, _escala, _angulo, 
    c_black, c_black, c_black, c_black, 0.7
);

draw_text_transformed_color(
    _pos_x, _pos_y, _texto, 
    _escala, _escala, _angulo, 
    _cor_arcoiris, _cor_arcoiris, c_yellow, c_yellow, 1.0
);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion