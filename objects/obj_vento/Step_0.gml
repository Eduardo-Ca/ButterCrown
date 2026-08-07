#region LOGICA DO VENTO
var raio_atracao = 180; 
var obstaculo_proximo = instance_nearest(x, y, obj_obstaculo);

if (instance_exists(obstaculo_proximo)) {
    var dist = point_distance(x, y, obstaculo_proximo.x, obstaculo_proximo.y);
    
    if (dist <= raio_atracao) {
        var dir_alvo = point_direction(x, y, obstaculo_proximo.x, obstaculo_proximo.y);
        var diff = angle_difference(dir_alvo, direcao);
        direcao += clamp(diff, -5, 5);
    }
}

x += lengthdir_x(vel_vento, direcao) + global.vel_mundo;
y += lengthdir_y(vel_vento, direcao);

with (obj_obstaculo) {
    if (place_meeting(x, y, other)) {
        vel_empurrao_x = lengthdir_x(other.forca_base_vento * leveza, other.direcao);
        vel_empurrao_y = lengthdir_y(other.forca_base_vento * leveza, other.direcao);
    }
}
#endregion