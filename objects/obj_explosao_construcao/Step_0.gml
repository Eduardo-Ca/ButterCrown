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

                
            vel_vertical = other.forca_impulso_borboleta;
                
            image_xscale = 0.4;
            image_yscale = 1.6;

        }
    }
}
}