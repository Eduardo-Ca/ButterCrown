#region PAUSA
if (global.pausado) exit;
#endregion

if (!instance_exists(obj_gato_gigante)) {
	instance_destroy();
}

#region FLUTUACAO CONSTANTE
tempo_flutuacao += 0.08;
var _offset_flutuacao = sin(tempo_flutuacao) * 0.6;
#endregion

#region MOVIMENTO EM DIRECAO AO GATO
timer_avanco--;

if (timer_avanco <= 0) {
    timer_avanco = game_get_speed(gamespeed_fps); 
    
    if (instance_exists(obj_gato_gigante)) {
        var _dir = point_direction(x, y, obj_gato_gigante.x, obj_gato_gigante.y);
        
        vel_x = lengthdir_x(forca_avanco, _dir);
        vel_y = lengthdir_y(forca_avanco, _dir);
        
     
    }
}


vel_x *= fator_atrito;
vel_y *= fator_atrito;

x += vel_x;
y += vel_y + _offset_flutuacao;
#endregion
