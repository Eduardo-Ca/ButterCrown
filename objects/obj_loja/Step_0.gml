#region LOGICA DA LOJA
timer_loja += 0.05;
painel_escala = lerp(painel_escala, 1.0, 0.15);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var espacamento = 48;
var margem_topo = 110;
var margem_baixo = 40;

var ph_base = margem_topo + (total_upgrades * espacamento) + margem_baixo;
var ph = ph_base * painel_escala;

var px = gui_w / 2;
var py = gui_h / 2;

var start_y = py - ph/2 + margem_topo;

hover_item = -1;

for (var i = 0; i < total_upgrades; i++) {
    var item_y = start_y + (i * espacamento);
    
    var btn_x1 = px + 210;
    var btn_y1 = item_y - 14;
    var btn_x2 = px + 300;
    var btn_y2 = item_y + 14;
    
    if (point_in_rectangle(mx, my, btn_x1, btn_y1, btn_x2, btn_y2)) {
        hover_item = i;
        
        if (mouse_check_button_pressed(mb_left)) {
            var upg = upgrades[i];
            var lvl_atual = variable_global_get(upg.nivel_global);
            var preco = upg.preco_base + (lvl_atual * upg.esc);
            
            if (global.caos >= preco && lvl_atual < upg.max_lvl) {
                global.caos -= preco;
                
                variable_global_set(upg.nivel_global, lvl_atual + 1);
                
                global.energia_maxima     = global.energia_max_base + (global.upg_energia_nivel * global.energia_max_por_nivel);
                global.forca_impulso      = global.impulso_base + (global.upg_impulso_nivel * global.impulso_por_nivel);
                global.quiques_maximos    = global.quiques_max_base + (global.upg_quiques_nivel * global.quiques_max_por_nivel);
                global.boost_por_impulso  = global.boost_base + (global.upg_boost_nivel * global.boost_por_nivel);
                global.velocidade_maxima  = global.velocidade_maxima_base + (global.upg_limite_vel_nivel * global.vel_max_por_nivel);
                
                global.vel_inicial_atual  = global.vel_inicial_base + (global.upg_vel_inicial_nivel * global.vel_inicial_por_nivel);
                
                if (audio_exists(snd_up)) {
                    audio_play_sound(snd_up, 8, false);
                }
            }
        }
    }
}

var btn_jogar_y = py + ph/2 + 35;
if (point_in_rectangle(mx, my, px - 120, btn_jogar_y - 25, px + 120, btn_jogar_y + 25)) {
    if (mouse_check_button_pressed(mb_left)) {
        global.vel_mundo = global.vel_inicial_atual;
        global.distancia_percorrida = 0;
        room_restart();
    }
}
#endregion