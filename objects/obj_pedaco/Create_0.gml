image_index = irandom(image_number - 1);
image_speed = 0; 

hspeed = random_range(-4, 4);
vspeed = random_range(-3, -6);
gravity = 0.25;

rotacao_vel = random_range(-12, 12);

tempo_no_chao = game_get_speed(gamespeed_fps) * random_range(4, 7); 
no_chao = false;

var escala_aleatoria = random_range(0.7, 1.4);
image_xscale = escala_aleatoria;
image_yscale = escala_aleatoria;

hspeed_salva = 0;
vspeed_salva = 0;
gravity_salva = 0;
pausado_antes = false;