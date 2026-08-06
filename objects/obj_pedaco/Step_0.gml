if (global.pausado) {
    if (!pausado_antes) {
        hspeed_salva = hspeed;
        vspeed_salva = vspeed;
        gravity_salva = gravity;
        
        hspeed = 0;
        vspeed = 0;
        gravity = 0;
        pausado_antes = true;
    }
    exit; 
} else {
    if (pausado_antes) {
        hspeed = hspeed_salva;
        vspeed = vspeed_salva;
        gravity = gravity_salva;
        
        pausado_antes = false;
    }
}

if (y > room_height + 64) {
    instance_destroy();
    exit;
}

if (!no_chao) {
    image_angle += rotacao_vel;
    x -= global.vel_mundo;
    
    if (place_meeting(x, y + vspeed, obj_chao)) {
        var trava_seguranca = 0;
        while (!place_meeting(x, y + sign(vspeed), obj_chao) && trava_seguranca < 100) {
            y += sign(vspeed);
            trava_seguranca++;
        }
        
        if (abs(vspeed) > 1.5) {
            vspeed = -vspeed * 0.3; 
            hspeed *= 0.5;
            rotacao_vel = -rotacao_vel * 0.5;
        } else {
            vspeed = 0;
            hspeed = 0;
            gravity = 0;
            rotacao_vel = 0;
            no_chao = true;
            
            image_angle = choose(0, 90, 180, 270) + random_range(-15, 15);
            y += irandom_range(1, 3);
        }
    }
} else {
    x -= global.vel_mundo; 
    
    tempo_no_chao--;
    
    if (tempo_no_chao <= 0) {
        image_alpha -= 0.02;
        image_xscale -= 0.02;
        image_yscale -= 0.02;
        if (image_alpha <= 0.5 || image_xscale <= 0) {
            instance_destroy();
        }
    }
}