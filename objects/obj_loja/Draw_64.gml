#region RECORDE
if (!variable_global_exists("recorde_distancia")) global.recorde_distancia = 0;

var gui_w = display_get_gui_width();
var _tempo_cor = (current_time / 10) % 255;
var _cor_brilhante = make_color_hsv(_tempo_cor, 255, 255);

var _texto = "RECORDE: " + string(floor(global.recorde_distancia)) + " m";
var _escala = 1.2;
var _pos_x = gui_w / 2;
var _pos_y = 60;

var _largura_texto = string_width(_texto) * _escala;
var _altura_texto = string_height(_texto) * _escala;
var _padding_x = 16;
var _padding_y = 8;

var _x1 = _pos_x - (_largura_texto / 2) - _padding_x;
var _y1 = _pos_y - _padding_y;
var _x2 = _pos_x + (_largura_texto / 2) + _padding_x;
var _y2 = _pos_y + _altura_texto + _padding_y;

draw_set_color(c_black);
draw_set_alpha(0.65);
draw_roundrect_ext(_x1, _y1, _x2, _y2, 12, 12, false);

draw_set_color(_cor_brilhante);
draw_set_alpha(0.8);
draw_roundrect_ext(_x1, _y1, _x2, _y2, 12, 12, true);

draw_set_alpha(1.0);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_set_color(c_black);
draw_text_transformed(_pos_x + 2, _pos_y + 2, _texto, _escala, _escala, 0);

draw_set_color(_cor_brilhante);
draw_text_transformed(_pos_x, _pos_y, _texto, _escala, _escala, 0);
#endregion

#region LOJA
var gui_h = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.75 * painel_escala);
draw_rectangle(0, 0, gui_w, gui_h, false);

var espacamento = 48; 
var margem_topo = 110;
var margem_baixo = 40;

var ph_base = margem_topo + (total_upgrades * espacamento) + margem_baixo;
var ph = ph_base * painel_escala;
var pw = 680 * painel_escala; 

var px = gui_w / 2;
var py = gui_h / 2;

draw_set_alpha(0.9 * painel_escala);
draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, false);

draw_set_color(c_yellow);
draw_set_alpha(painel_escala);
draw_roundrect_ext(px - pw/2, py - ph/2, px + pw/2, py + ph/2, 16, 16, true);

if (painel_escala > 0.8) {
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(c_yellow);
    draw_text_transformed(px, py - ph/2 + 35, "-- LOJA DE UPGRADES --", 1.2, 1.2, 0);
    
    draw_set_color(make_color_rgb(255, 140, 0));
    draw_text(px, py - ph/2 + 68, "CAOS: " + string(global.caos));
    
    var start_y = py - ph/2 + margem_topo;
    
    for (var i = 0; i < total_upgrades; i++) {
        var upg = upgrades[i];
        var item_y = start_y + (i * espacamento);
        var lvl_atual = variable_global_get(upg.nivel_global);
        var preco = upg.preco_base + (lvl_atual * upg.esc);
        
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_text(px - 300, item_y, upg.nome);
        
        var bar_x = px - 30;
        for (var b = 0; b < upg.max_lvl; b++) {
            var bx = bar_x + (b * 22);
            if (b < lvl_atual) {
                draw_set_color(c_lime);
                draw_rectangle(bx, item_y - 10, bx + 15, item_y + 10, false);
            } else {
                draw_set_color(c_dkgray);
                draw_rectangle(bx, item_y - 10, bx + 15, item_y + 10, true);
            }
        }
        
        draw_set_halign(fa_center);
        var btn_x1 = px + 210;
        var btn_y1 = item_y - 14;
        var btn_x2 = px + 300;
        var btn_y2 = item_y + 14;
        
        if (lvl_atual >= upg.max_lvl) {
            draw_set_color(c_gray);
            draw_roundrect(btn_x1, btn_y1, btn_x2, btn_y2, false);
            draw_set_color(c_white);
            draw_text(px + 255, item_y, "MAX");
        } else {
            var esta_hover = (hover_item == i);
            var tem_caos = (global.caos >= preco);
            
            draw_set_color(tem_caos ? (esta_hover ? c_lime : c_green) : c_red);
            draw_roundrect(btn_x1, btn_y1, btn_x2, btn_y2, false);
            
            draw_set_color(c_black);
            draw_text(px + 255, item_y, string(preco) + " C");
        }
    }
    
    var btn_jogar_y = py + ph/2 + 35;
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var h_jogar = point_in_rectangle(mx, my, px - 120, btn_jogar_y - 25, px + 120, btn_jogar_y + 25);
    
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