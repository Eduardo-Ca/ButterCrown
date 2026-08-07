#region COMPRA
timer_loja += 0.05;
painel_escala = lerp(painel_escala, 1.0, 0.15);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var start_y = gui_h * 0.35;
var espacamento = 50;

hover_item = -1;

for (var i = 0; i < total_upgrades; i++) {
    var item_y = start_y + (i * espacamento);
    var btn_x1 = gui_w / 2 + 80;
    var btn_y1 = item_y - 12;
    var btn_x2 = gui_w / 2 + 160;
    var btn_y2 = item_y + 12;
    
    if (point_in_rectangle(mx, my, btn_x1, btn_y1, btn_x2, btn_y2)) {
        hover_item = i;
        
        if (mouse_check_button_pressed(mb_left)) {
            var upg = upgrades[i];
            var lvl_atual = variable_global_get(upg.nivel_global);
            var preco = upg.preco_base + (lvl_atual * upg.esc);
            
            if (global.caos >= preco && lvl_atual < upg.max_lvl) {
                global.caos -= preco;
                variable_global_set(upg.nivel_global, lvl_atual + 1);
                
                global.energia_maxima = global.energia_max_base + (global.upg_energia_nivel * global.energia_max_por_nivel);
                global.forca_impulso = global.impulso_base + (global.upg_impulso_nivel * global.impulso_por_nivel);
                global.quiques_maximos = global.quiques_max_base + (global.upg_quiques_nivel * global.quiques_max_por_nivel);
                global.boost_por_impulso = global.boost_base + (global.upg_boost_nivel * global.boost_por_nivel);
                
                if (audio_exists(snd_up)) {
                    audio_play_sound(snd_up, 8, false);
                }
            }
        }
    }
}


var btn_jogar_y = gui_h * 0.82;
if (point_in_rectangle(mx, my, gui_w/2 - 100, btn_jogar_y - 20, gui_w/2 + 100, btn_jogar_y + 20)) {
    if (mouse_check_button_pressed(mb_left)) {
        room_restart();
    }
}
#endregion