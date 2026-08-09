#region TRAVA DE PAUSA 
if (global.pausado) {
    exit;           
}
#endregion
tocar_som(snd_estrela);
#region DISPARAR ESTRELAS 
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    var _vel_estrela = 2.5;
    var _abertura = 105;
    
    var _dir_alvo = point_direction(x, y, obj_borboleta.x, obj_borboleta.y);
    
    var _estrela_meio = instance_create_layer(x - 10, y, layer, obj_estrela);
    with (_estrela_meio) {
        speed = _vel_estrela;
        direction = _dir_alvo;
        image_angle = direction;
    }
    
    var _estrela_cima = instance_create_layer(x - 10, y - 8, layer, obj_estrela);
    with (_estrela_cima) {
        speed = _vel_estrela;
        direction = _dir_alvo + _abertura;
        image_angle = direction;
    }
    
    var _estrela_baixo = instance_create_layer(x - 10, y + 8, layer, obj_estrela);
    with (_estrela_baixo) {
        speed = _vel_estrela;
        direction = _dir_alvo - _abertura;
        image_angle = direction;
    }
}

alarm[0] = game_get_speed(gamespeed_fps) * 3;
#endregion