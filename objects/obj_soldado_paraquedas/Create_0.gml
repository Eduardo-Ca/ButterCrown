event_inherited();

#region CONFIGURACAO
nome = "Soldado";
sprite_assustado = spr_soldado_paraquedas;

vel_queda = random_range(1, 1.8);
tempo_balanco = random(100);
ang_balanco = 0;
ang_max = 14;

CORTE_SOLDADO = 26;
meia_altura = sprite_get_height(spr_soldado_paraquedas) - sprite_get_yoffset(spr_soldado_paraquedas);
#endregion

#region ESTADO
pousou = false;
paraquedas_rasgou = false;
soldado_sumiu = false;
alpha_para = 1;
vel_y = 0;
rot_queda = 0;
#endregion

#region PARAQUEDAS SOLTO
para_x = x;
para_y = y;
para_vy = 0;
para_t = 0;
para_alpha = 0;
#endregion