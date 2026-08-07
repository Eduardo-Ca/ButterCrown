#region DESENHAR MENU DE PAUSA
if (global.pausado) {
 
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_text(room_width / 2, room_height / 2 - 20, "JOGO PAUSADO");
    draw_text(room_width / 2, room_height / 2 + 20, "Pressione P para Voltar");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
#endregion

#region DRAW LOGS PAUSA
if (global.pausado) {
    var gui_h = display_get_gui_height();
    
    var start_x = 40;
    var start_y = gui_h - 60;
    var espacamento = 24;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    var total = array_length(global.logs_eventos);
    
    if (total > 0) {
        draw_set_color(c_yellow);
        draw_text(start_x, start_y - (total * espacamento) - 10, "--- REAÇÕES EM CADEIA ---");
        
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