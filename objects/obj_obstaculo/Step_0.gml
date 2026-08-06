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