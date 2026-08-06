#region PAUSA
if (global.pausado) exit;
#endregion

#region SEGUIR JOGADOR
if (instance_exists(obj_borboleta)) {
    var borboleta = obj_borboleta;
    
    var offset_y_borboleta = (borboleta.vel_vertical > 0) ? (borboleta.vel_vertical * 10) : (borboleta.vel_vertical * 5);
    
    var alvo_x_final = borboleta.x;
    var alvo_y_final = borboleta.y + offset_y_borboleta;
    
    var offset_shake_x = 0;
    var offset_shake_y = 0;
    
    if (shake_intensidade > 0.05) {
        shake_tempo += 0.8;
        offset_shake_x = sin(shake_tempo * 1.7) * shake_intensidade;
        offset_shake_y = cos(shake_tempo * 1.3) * shake_intensidade;
        shake_intensidade = lerp(shake_intensidade, 0, 0.15);
    } else {
        shake_intensidade = 0;
        shake_tempo = 0;
    }

    var pos_x_desejada = (alvo_x_final - (largura_base / 2)) + offset_shake_x;
    var pos_y_desejada = (alvo_y_final - (altura_base / 2)) + offset_shake_y;
    
    x = lerp(x, pos_x_desejada, 0.15);
    y = lerp(y, pos_y_desejada, 0.15);
    
    camera_set_view_pos(view_camera[0], x, y);
}
#endregion