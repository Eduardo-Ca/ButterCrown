#region COLISAO COM BORBOLETA
if (!other.morto && !assustado) {
	tremer_tela(6);
    other.vel_vertical = -5.5;
    other.image_xscale = 1.4;
    other.image_yscale = 0.6;
    other.quiques_atuais = 0;
    
    global.vel_mundo = clamp(global.vel_mundo + boost_velocidade, 0, global.velocidade_maxima);
    global.caos_pontos += pontos_caos;
    
    assustado = true;
    sprite_index = spr_balao_vazio;
    
    escala_x = 1.5;
    escala_y = 0.5;
    vel_angulo = choose(-35, 35);
    
    fase_fuga = 0;
    timer_fuga = 0;
    direcao_fuga_x = choose(-1, 1);
    vel_fuga_y = 2;
    vel_fuga_x = 0;
}
#endregion