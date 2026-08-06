#region GERENCIAMENTO DO MUNDO
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    if (global.vel_mundo > 0) {
        global.vel_mundo = max(0, global.vel_mundo - global.atrito_ar);
    }
    global.distancia_percorrida += global.vel_mundo * 0.05;
} else {
    global.vel_mundo = lerp(global.vel_mundo, 0, 0.1);
}
#endregion