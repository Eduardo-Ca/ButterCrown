event_inherited();
#region TRAVA DE PAUSA 
if (global.pausado) {
	alarm[0] += 1;
    exit;           
}
#endregion
#region MOVIMENTO 
if (instance_exists(obj_borboleta)) {
    tempo_flutuar += 0.025;
    
    var _raio_x = 35;
    var _raio_y = 20;
    
    var _deslocamento_x = sin(tempo_flutuar) * _raio_x;
    var _deslocamento_y = sin(tempo_flutuar * 2) * _raio_y;
    
    var _x_desejado = obj_borboleta.x + distancia_x_borboleta + _deslocamento_x;
    var _y_desejado = obj_borboleta.y + offset_y_borboleta + _deslocamento_y;
    
    x = lerp(x, _x_desejado, 0.05);
    y = lerp(y, _y_desejado, 0.05);
    

}
#endregion

var _limite_topo = 260;
y = max(y, _limite_topo);
#endregion