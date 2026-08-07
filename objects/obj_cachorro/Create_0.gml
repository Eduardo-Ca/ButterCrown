event_inherited();

nome = "Cachorro";

image_xscale = 0.6;
image_yscale = 0.6;

leveza = 0.7; 
boost_velocidade = 0.6;
#region VARIAVEIS DE ESTADO E ANIMACAO

image_index = 0;

assustado = false;
tempo_caminhada = random(100);
vel_caminhada = 0.25;
vel_fuga_chao = 3;

y_base = y;
angulo_maximo = 0;
altura_passo = 1.5;
fator_vel_fuga = 1;

sprite_assustado = spr_cachorro_mordendo;
#endregion

