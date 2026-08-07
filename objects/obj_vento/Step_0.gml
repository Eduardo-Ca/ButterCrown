x += lengthdir_x(vel_vento, direcao) + global.vel_mundo;
y += lengthdir_y(vel_vento, direcao);


with (obj_obstaculo) {
    if (place_meeting(x, y, other)) {
       
        vel_empurrao_x = lengthdir_x(other.forca_base_vento * leveza, other.direcao);
        vel_empurrao_y = lengthdir_y(other.forca_base_vento * leveza, other.direcao);
    }
}