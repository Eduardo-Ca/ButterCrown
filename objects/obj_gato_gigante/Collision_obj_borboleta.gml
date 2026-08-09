tocar_som(snd_golpe);
            
other.vel_vertical = -2.5;
other.image_xscale = 1.4;
other.image_yscale = 0.6;
other.quiques_atuais = 0;
            
global.vel_mundo = clamp(global.vel_mundo + 0.2, 0, global.velocidade_maxima);