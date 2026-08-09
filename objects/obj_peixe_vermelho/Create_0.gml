event_inherited();

event_inherited();
max_vida = 20;
vida = max_vida;
nome_boss = "REIS ABISSAIS";
eh_boss_secundario = false;

image_xscale = 2;
image_yscale = 2;

#region INICIALIZACAO VERMELHO
tempo_flutuar = random(100);
distancia_x_borboleta = 230;
offset_y_borboleta = -20;
#endregion

alarm[0] = game_get_speed(gamespeed_fps) * 3;