event_inherited();
#region TRAVA DE PAUSA 
if (global.pausado) {
    exit;           
}
#endregion
#region MOVIMENTO 
if (instance_exists(obj_borboleta)) {
    tempo_flutuar += 0.03;
    
    var _x_desejado = obj_borboleta.x + distancia_x_borboleta + cos(tempo_flutuar * 0.7) * 20;
    var _y_desejado = obj_borboleta.y + offset_y_borboleta + sin(tempo_flutuar) * 18;
    
    x = lerp(x, _x_desejado, 0.08);
    y = lerp(y, _y_desejado, 0.08);
}
#endregion

var _limite_topo = 280;
y = max(y, _limite_topo);
#endregion

