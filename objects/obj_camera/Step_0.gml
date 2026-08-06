#region MOVIMENTO
if (instance_exists(obj_borboleta)) {
    var borboleta = obj_borboleta;
    
    var fator_visio_baixo = 0;
    var velocidade_lerp = 0.08;
    
    if (borboleta.vel_vertical > 0) {
        fator_visio_baixo = borboleta.vel_vertical * 22;
        velocidade_lerp = 0.15;
    } else {
        fator_visio_baixo = borboleta.vel_vertical * 8;
        velocidade_lerp = 0.08;
    }
    
    var alvo_y = borboleta.y + fator_visio_baixo;
    
    var offset_x = random_range(-shake_intensidade, shake_intensidade);
    var offset_y = random_range(-shake_intensidade, shake_intensidade);
    
    y = lerp(y, alvo_y, velocidade_lerp) + offset_y;
    x = offset_x;
    
    shake_intensidade *= shake_amortecimento;
    if (shake_intensidade < 0.1) {
        shake_intensidade = 0;
    }
}
#endregion