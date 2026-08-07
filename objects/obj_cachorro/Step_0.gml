
#region TRAVA DE PAUSA PERFEITA
if (global.pausado) {
    image_speed = 0; 
    exit;           
} else {
    image_speed = 1;
}
#endregion

event_inherited();

#region ANIMACAO E MOVIMENTO DE FUGA
if (!assustado) {
    image_xscale = 1; 
    
    if (global.vel_mundo > 0) {
        tempo_caminhada += vel_caminhada * (global.vel_mundo * 0.3);
        
        image_angle = sin(tempo_caminhada) * angulo_maximo;
        y = y_base - abs(sin(tempo_caminhada)) * altura_passo;
    } else {
        image_angle = lerp(image_angle, 0, 0.2);
        y = lerp(y, y_base, 0.2);
    }
} else {

    image_xscale = -1;
    
    var vel_corrida = max(global.vel_mundo * fator_vel_fuga, 2.5);
    x += vel_corrida;
    
    tempo_caminhada += 0.5;
    image_angle = sin(tempo_caminhada * 2) * 12;
    y = y_base - abs(sin(tempo_caminhada * 2)) * 3;

    if (!variable_instance_exists(id, "timer_assustado")) {
        timer_assustado = 300;
    }

    timer_assustado -= 1;

    if (timer_assustado <= 0) {
		image_alpha -= 0.1;
		if((image_alpha <= 0)){
			instance_destroy();
		}
    }
}
#endregion