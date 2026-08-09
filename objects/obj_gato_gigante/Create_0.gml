event_inherited();

x= 239;
y = 866;

max_vida = 40;
vida = max_vida;
nome_boss = "BORBOLETAS DO CAOS";
eh_boss_secundario = false;

timer_dano_continuo = game_get_speed(gamespeed_fps)*4; 
#region  POEIRA
tempo_poeira = 0;
intervalo_poeira = 1;
#endregion

vida_real = 3;
morto = false;