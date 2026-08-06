#region MOVIMENTO DO MUNDO E AUTO-DESTRUICAO

x -= global.vel_mundo;

if (bbox_right < 0 or bbox_left < 0) {
    instance_destroy();
}
#endregion