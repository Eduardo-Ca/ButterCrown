event_inherited();

if (y <= 0) {
    instance_destroy();
}

#region COMPENSAR VELOCIDADE DO PAI

x += global.vel_mundo * 0.6; 
#endregion

#region TRAVA DE PAUSA
if (global.pausado) {
    image_speed = 0; 
    exit;           
} else {
    image_speed = 1;
}
#endregion

if (!assustado) {

    if (instance_exists(obj_borboleta)) {
        var dist = distance_to_object(obj_borboleta);
        var raio_perseguicao = 150;
        var velocidade = 0.8;      
        
        if (dist <= raio_perseguicao) {
            tempo_flutuacao += 0.03;
            
            var _dir_base = point_direction(x, y, obj_borboleta.x, obj_borboleta.y);
            var _desvio_lateral = sin(tempo_flutuacao) * 0.8;
            
            x += lengthdir_x(velocidade, _dir_base) + lengthdir_x(_desvio_lateral, _dir_base + 90);
            y += lengthdir_y(velocidade, _dir_base) + lengthdir_y(_desvio_lateral, _dir_base + 90);
            speed = 0;
        } else {
            speed = 0;
            tempo_flutuacao += 0.02;
            
            x += cos(tempo_flutuacao * 0.8) * 0.2;
            y -= 0.15 + sin(tempo_flutuacao) * 0.1;
        }
    } else {
        speed = 0;
        tempo_flutuacao += 0.02;
        
        x += cos(tempo_flutuacao * 0.8) * 0.2;
        y -= 0.15 + sin(tempo_flutuacao) * 0.1;
    }

    image_xscale = 2 + sin(tempo_flutuacao * 1.2) * 0.04;
    image_yscale = 2 - sin(tempo_flutuacao * 1.2) * 0.04;

    timer_rastro += 1;
    if (timer_rastro >= 3) {
        timer_rastro = 0;
    }
} else {
    speed = 0;
}