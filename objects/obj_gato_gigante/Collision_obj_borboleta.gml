#region CANCELAR PODERES
if (other.modo_meteoro || other.modo_dobra) {
    other.modo_meteoro = false;
    other.modo_dobra = false;
    other.image_angle = 0;
    global.vel_mundo = min(global.vel_mundo, global.velocidade_maxima);

    tremer_tela(8);
    zoom_punch(0.1);
}
#endregion
tocar_som(snd_golpe);
            
other.vel_vertical = -2.5;
other.image_xscale = 1.4;
other.image_yscale = 0.6;
other.quiques_atuais = 0;
            
global.vel_mundo = clamp(global.vel_mundo + 0.2, 0, global.velocidade_maxima);