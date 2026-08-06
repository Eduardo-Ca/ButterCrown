#region MOVIMENTO E CAMERA SHAKE
if (global.pausado) exit; 

if (instance_exists(obj_borboleta)) {
    var borboleta = obj_borboleta;
    
    var fator_visao_baixo = 0;
    var velocidade_lerp = 0.08;
    
    if (borboleta.vel_vertical > 0) {
        fator_visao_baixo = borboleta.vel_vertical * 18; 
        velocidade_lerp = 0.12;
    } else {
        fator_visao_baixo = borboleta.vel_vertical * 8;
        velocidade_lerp = 0.06;
    }
    
    var alvo_y = borboleta.y + fator_visao_baixo;
    
    var offset_x = 0;
    var offset_y = 0;
    
    if (shake_intensidade > 0.05) {
  
        shake_tempo = variable_instance_exists(id, "shake_tempo") ? shake_tempo + 0.8 : 0;
        
        offset_x = sin(shake_tempo * 1.7) * shake_intensidade;
        offset_y = cos(shake_tempo * 1.3) * shake_intensidade;
        
        shake_intensidade = lerp(shake_intensidade, 0, 0.1);
    } else {
        shake_intensidade = 0;
        shake_tempo = 0;
    }
    

    y = lerp(y, alvo_y, velocidade_lerp) + offset_y;
    x = offset_x;
}
#endregion