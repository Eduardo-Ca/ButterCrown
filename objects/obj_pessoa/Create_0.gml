
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

#region ROUPAS ALEATORIAS
var total_cabeca = sprite_get_number(spr_cabeca);
var total_corpo  = sprite_get_number(spr_corpo);

cabeca_index = (total_cabeca > 0) ? irandom_range(-1, total_cabeca - 1) : -1;
corpo_index  = (total_corpo  > 0) ? irandom_range(-1, total_corpo  - 1) : -1;
#endregion