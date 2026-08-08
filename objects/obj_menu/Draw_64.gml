
#region 
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

gpu_set_blendmode(bm_add);
for (var i = 0; i < qtd_estrelas; i++) {
    var e = estrelas[i];
    draw_set_color(c_white);
    draw_set_alpha(e.alpha);
    draw_line_width(e.x, e.y, e.x - e.vel_x * 2, e.y - e.vel_y * 2, e.tamanho);
}
gpu_set_blendmode(bm_normal);

draw_set_alpha(1.0);

var titulo_x = gui_w / 2;
var titulo_y = gui_h * 0.25 + sin(timer_tempo) * 4;

if (sprite_exists(spr_titulo)) {
    draw_sprite_ext(spr_titulo, -1, titulo_x, titulo_y, 3, 3, 0, c_white, 1);
}


draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var start_y = gui_h * 0.52;
draw_set_color(c_black);
draw_text_transformed(gui_w / 2 + 3, start_y + 3, "START", start_escala, start_escala, 0);
draw_set_color(c_yellow);
draw_text_transformed(gui_w / 2, start_y, "START", start_escala, start_escala, 0);

var ctrl_y = gui_h * 0.65;
draw_set_color(c_black);
draw_text_transformed(gui_w / 2 + 2, ctrl_y + 2, "[ CONTROLES ]", ctrl_escala, ctrl_escala, 0);
draw_set_color(cor_cyan);
draw_text_transformed(gui_w / 2, ctrl_y, "[ CONTROLES ]", ctrl_escala, ctrl_escala, 0);

if (painel_escala > 0.01) {
    var pw = 360 * painel_escala;
    var ph = 260 * painel_escala;
    var px = gui_w / 2;
    var py = gui_h / 2;
    
    draw_set_color(c_black);
    draw_set_alpha(0.9 * painel_escala);
    draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, false);
    
    draw_set_color(cor_cyan);
    draw_set_alpha(painel_escala);
    draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, true);
    
    if (painel_escala > 0.8) {
        draw_set_color(c_yellow);
        draw_text_transformed(px, py - 90, "-- CONTROLES --", 1.1, 1.1, 0);
        
        draw_set_color(c_white);
        draw_text(px, py - 40, "Mouse Esquerdo : Voar");
        draw_set_color(cor_cyan);
        draw_text(px, py, "Mouse Direito : Bater Asas");
        draw_set_color(c_orange);
        draw_text(px, py + 40, "Tecla P : Pausar");
        
        var fechar_y = py + 95;
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        var m_fechar = point_in_rectangle(mx, my, px - 80, fechar_y - 15, px + 80, fechar_y + 15);
        
        var esc_f = m_fechar ? 1.15 : 1.0;
        draw_set_color(c_black);
        draw_text_transformed(px + 2, fechar_y + 2, "< VOLTAR >", esc_f, esc_f, 0);
        draw_set_color(m_fechar ? c_lime : c_red);
        draw_text_transformed(px, fechar_y, "< VOLTAR >", esc_f, esc_f, 0);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion