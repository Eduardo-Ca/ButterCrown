event_inherited();

nome = "Bolha";

#region PROPRIEDADES DO CAOS
pontos_caos = 0;
boost_velocidade = 0.3;
sprite_assustado = spr_bolha_estorando;
#endregion

tempo_flutuacao = random(pi * 2);
escala_morte = 1.0;
timer_morte = 180;
timer_rastro = 0;

image_xscale = 4;
image_yscale = 4;
