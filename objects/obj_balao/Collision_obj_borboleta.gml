#region COLISAO E IMPULSO
if (!other.morto) {
    other.vel_vertical = -6;
    other.image_xscale = 1.5;
    other.image_yscale = 0.5;
    other.quiques_atuais = 0;
    
    global.vel_mundo = clamp(global.vel_mundo + boost_velocidade, 0, global.velocidade_maxima);
    global.caos_pontos += pontos_caos;
    
    instance_destroy();
}
#endregion