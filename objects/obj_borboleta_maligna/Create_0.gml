cor =  make_color_hsv(irandom(255), 255, 255);

image_blend = cor
image_xscale = -1;

#region
timer_avanco = game_get_speed(gamespeed_fps); 
tempo_flutuacao = 0;

vel_x = 0;
vel_y = 0;
fator_atrito = 0.92; 
forca_avanco = 4.5;
#endregion