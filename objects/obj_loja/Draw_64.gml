#region RENDERIZACAO DA LOJA
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.75 * painel_escala);
draw_rectangle(0, 0, gui_w, gui_h, false);

var pw = 460 * painel_escala;
var ph = 380 * painel_escala;
var px = gui_w / 2;
var py = gui_h / 2;

draw_set_alpha(0.9 * painel_escala);
draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, false);

draw_set_color(c_yellow);
draw_set_alpha(painel_escala);
draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, true);

if (painel_escala > 0.8) {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(c_yellow);
    draw_text_transformed(px, py - ph/2 + 30, "-- LOJA DE UPGRADES --", 1.2, 1.2, 0);
    
   	draw_set_color(make_color_rgb(255, 140, 0));
    draw_text(px, py - ph/2 + 55, "CAOS: " + string(global.caos));
    
    var start_y = gui_h * 0.35;
    var espacamento = 50;
    
    for (var i = 0; i < total_upgrades; i++) {
        var upg = upgrades[i];
        var item_y = start_y + (i * espacamento);
        var lvl_atual = variable_global_get(upg.nivel_global);
        var preco = upg.preco_base + (lvl_atual * upg.esc);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_text(px - 200, item_y, upg.nome);
        
        var bar_x = px - 40;
        for (var b = 0; b < upg.max_lvl; b++) {
            var bx = bar_x + (b * 18);
            if (b < lvl_atual) {
                draw_set_color(c_lime);
                draw_rectangle(bx, item_y - 8, bx + 12, item_y + 8, false);
            } else {
                draw_set_color(c_dkgray);
                draw_rectangle(bx, item_y - 8, bx + 12, item_y + 8, true);
            }
        }
        
        draw_set_halign(fa_center);
        var btn_x1 = px + 80;
        var btn_y1 = item_y - 12;
        var btn_x2 = px + 160;
        var btn_y2 = item_y + 12;
        
        if (lvl_atual >= upg.max_lvl) {
            draw_set_color(c_gray);
            draw_roundrect(btn_x1, btn_y1, btn_x2, btn_y2, false);
            draw_set_color(c_white);
            draw_text(px + 120, item_y, "MAX");
        } else {
            var esta_hover = (hover_item == i);
            var tem_caos = (global.caos >= preco);
            
            draw_set_color(tem_caos ? (esta_hover ? c_lime : c_green) : c_red);
            draw_roundrect(btn_x1, btn_y1, btn_x2, btn_y2, false);
            
            draw_set_color(c_black);
            draw_text(px + 120, item_y, string(preco) + " C");
        }
    }
    

    var btn_jogar_y = gui_h * 0.82;
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var h_jogar = point_in_rectangle(mx, my, px - 100, btn_jogar_y - 20, px + 100, btn_jogar_y + 20);
    
    var esc_j = h_jogar ? 1.15 : 1.0;
    draw_set_color(c_black);
    draw_text_transformed(px + 2, btn_jogar_y + 2, "[ JOGAR NOVAMENTE ]", esc_j, esc_j, 0);
    draw_set_color(h_jogar ? c_yellow : c_white);
    draw_text_transformed(px, btn_jogar_y, "[ JOGAR NOVAMENTE ]", esc_j, esc_j, 0);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion