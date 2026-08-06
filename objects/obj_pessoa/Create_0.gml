
event_inherited();

#region VARIAVEIS DE ESTADO E ANIMACAO
image_speed = 0;
image_index = 0;

assustado = false;
tempo_caminhada = random(100);
vel_caminhada = 0.25;
vel_fuga_chao = 3;

y_base = y;
angulo_maximo = 6;
altura_passo = 1.5;
fator_vel_fuga = 0.85;

sprite_assustado = spr_pessoa_assustada;
#endregion