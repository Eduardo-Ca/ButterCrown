#region LOGICA DO MENU E INTERACAO
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

timer_tempo += 0.05;

for (var i = 0; i < qtd_estrelas; i++) {
    var e = estrelas[i];
    e.y += e.vel_y;
    e.x += e.vel_x;
    
    if (e.y > gui_h + 10 || e.x < -10) {
        e.y = -10;
        e.x = random(gui_w + 200);
        e.vel_y = random_range(2, 6);
        e.tamanho = random_range(1, 3);
        e.alpha = random_range(0.3, 0.9);
    }
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var start_y = gui_h * 0.52;
var ctrl_y = gui_h * 0.65;

var mouse_start = point_in_rectangle(mx, my, gui_w/2 - 120, start_y - 25, gui_w/2 + 120, start_y + 25);
var mouse_ctrl = point_in_rectangle(mx, my, gui_w/2 - 140, ctrl_y - 25, gui_w/2 + 140, ctrl_y + 25);

if (!mostrar_controles) {
    if (mouse_start) {
        start_escala = lerp(start_escala, 1.25, 0.2);
        if (mouse_check_button_pressed(mb_left)) {
            audio_stop_sound(snd_musica_tema_1);
            room_goto(jogo);
        }
    } else {
        start_escala = lerp(start_escala, 1.0 + sin(timer_tempo * 2) * 0.05, 0.1);
    }

    if (mouse_ctrl) {
        ctrl_escala = lerp(ctrl_escala, 1.2, 0.2);
        if (mouse_check_button_pressed(mb_left)) {
            mostrar_controles = true;
        }
    } else {
        ctrl_escala = lerp(ctrl_escala, 1.0, 0.1);
    }
} else {
    start_escala = lerp(start_escala, 1.0, 0.1);
    ctrl_escala = lerp(ctrl_escala, 1.0, 0.1);
    
    var fechar_y = gui_h/2 + 165;
    var mouse_fechar = point_in_rectangle(mx, my, gui_w/2 - 80, fechar_y - 20, gui_w/2 + 80, fechar_y + 20);
    
    if ((mouse_fechar && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(vk_escape)) {
        mostrar_controles = false;
    }
}

painel_escala = lerp(painel_escala, mostrar_controles ? 1.0 : 0.0, 0.25);
#endregion