if (global.pausado) exit;
#region MOVIMENTO DO MUNDO E AUTO-DESTRUICAO

x -= global.vel_mundo ;

if (bbox_right < 0 or bbox_left < 0) {
    instance_destroy();
}
#endregion

var alvo_x = (assustado) ? -1 : 1; 

image_xscale = lerp(image_xscale, alvo_x, 0.15);
image_yscale = lerp(image_yscale, 1.0, 0.15);

#region APLICAR MOVIMENTO DO EMPURRAO
if (global.pausado) exit;

if (vel_empurrao_x > 0) {
    x += vel_empurrao_x;
    vel_empurrao_x = max(0, vel_empurrao_x - atrito_obstaculo);
}

if (abs(vel_empurrao_y) > 0) {
    y += vel_empurrao_y;
    vel_empurrao_y = lerp(vel_empurrao_y, 0, 0.1);
}
#endregion