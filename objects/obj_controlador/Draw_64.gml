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