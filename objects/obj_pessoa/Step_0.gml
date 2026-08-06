#region TRAVA DE PAUSA
if (global.pausado) exit;
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
}
#endregion

