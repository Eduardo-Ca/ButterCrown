event_inherited();

#region TRAVA DE PAUSA
if (global.pausado) {
    image_speed = 0; 
    exit;           
} else {
    image_speed = 1;
}
#endregion
image_angle += 1;
if (!assustado) {
    timer_rastro += 1;
    if (timer_rastro >= 3) {
        timer_rastro = 0;
        criar_rastro_dash(id, 0.05, 0.9, c_white);
    }
} else {

    speed = 0;
}

#region ESTADO ASSUSTADO E MORTE
if (assustado) {
    image_angle += 15;
    
    timer_morte -= 1;
    escala_morte = timer_morte / 180;
    
    image_xscale = escala_morte;
    image_yscale = escala_morte;
    image_alpha = escala_morte;

    if (timer_morte <= 0) {
        instance_destroy();
    }
}
#endregion