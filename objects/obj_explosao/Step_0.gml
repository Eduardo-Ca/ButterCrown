if (!processado) {
    processado = true;
    

    with (obj_obstaculo) {
        var dist = point_distance(x, y, other.x, other.y);
        
        if (dist <= other.raio_explosao) {
            var dir = point_direction(other.x, other.y, x, y);
            
            var fator_distancia = 1 - (dist / other.raio_explosao);
            var forca_final = other.forca_explosao_max * fator_distancia * leveza;
            
            vel_empurrao_x = lengthdir_x(forca_final, dir);
            vel_empurrao_y = lengthdir_y(forca_final, dir);
        }
    }
    
  
 var borboleta = collision_circle(x, y, raio_explosao, obj_borboleta, false, true);
    

    if (borboleta != noone) {
        with (borboleta) {
            if (!morto) {

                energia_atual = max(0, energia_atual - other.dano_energia);
                
                vel_vertical = other.forca_impulso_borboleta;
                
                image_xscale = 0.4;
                image_yscale = 1.6;
                	
				criar_texto_flutuante(obj_borboleta.x, obj_borboleta.y - 10, "-1", c_red, 3);
                if (audio_exists(snd_sem_energia)) {
                    tocar_som(snd_sem_energia);
                }
            }
        }
    }
}