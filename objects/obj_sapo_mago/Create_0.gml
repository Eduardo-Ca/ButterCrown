#region CONFIGURACAO
sprite_index = spr_sapo_mago;
duracao = 600;          // 10 segundos
timer = 0;
intervalo_nuvem = 45;   // frames entre nuvens
timer_nuvem = 15;
saindo = false;
escala = 34 / sprite_get_height(sprite_index);
#endregion

#region EFEITOS
alpha = 0;
cast = 0;
pulo = 0;
orbita = 0;
raio_t = 0;
raio_alvo = noone;
timer_particula = 0;

// posicao da ponta do cajado (fracao do sprite, a partir do centro)
ponta_x = 0.32;
ponta_y = -0.07;
#endregion