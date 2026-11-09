#region MENU DE PAUSA
if (global.pausado && !(instance_exists(obj_tutorial) && obj_tutorial.em_intro)) {
    var _gx = display_get_gui_width() / 2;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _over = -1;

    for (var i = 0; i < 2; i++) {
        var _py = pausa_y(i);
        if (point_in_rectangle(_mx, _my, _gx - pausa_w / 2, _py - pausa_h / 2, _gx + pausa_w / 2, _py + pausa_h / 2)) _over = i;
    }

    if (_over != -1 && _over != pausa_sel) {
        pausa_sel = _over;
        tocar_som(snd_golpe);
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        pausa_sel = 1 - pausa_sel;
        tocar_som(snd_golpe);
    }

    for (var i = 0; i < 2; i++) {
        pausa_esc[i] = lerp(pausa_esc[i], (i == pausa_sel) ? 1.1 : 1, 0.25);
    }

    if ((_over != -1 && mouse_check_button_pressed(mb_left)) || keyboard_check_pressed(vk_enter)) {
        pausa_acionar(pausa_sel);
    }
}
#endregion

if (global.pausado) exit;

#region GERENCIAMENTO DO MUNDO
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    if (global.vel_mundo > 0) {
        global.vel_mundo = max(0, global.vel_mundo - global.atrito_ar);
    }
    
    if (!instance_exists(obj_boss)) {
        global.distancia_percorrida += global.vel_mundo * 0.05;
		if (global.distancia_percorrida > global.recorde_distancia) {
		    global.recorde_distancia = floor(global.distancia_percorrida);
		}
		#endregion;
    }
} else {
    global.vel_mundo = lerp(global.vel_mundo, 0, 0.1);
}
#endregion

for (var i = array_length(global.logs_eventos) - 1; i >= 0; i--) {
    global.logs_eventos[i].timer--;
    
    if (global.logs_eventos[i].timer <= 0) {
        array_delete(global.logs_eventos, i, 1);
    }
}

if(instance_exists(obj_loja)){
	global.pausado = false;	
}



