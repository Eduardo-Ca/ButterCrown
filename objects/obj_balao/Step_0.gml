#region TRAVA DE PAUSA
if (global.pausado) {
    image_speed = 0; 
    exit;          
} else {
    image_speed = 1; 
}
#endregion

#region HERANCA E PARENT
event_inherited();
#endregion

#region FISICA DE MOLA E ESCALA
var forca = -mola_forca * angulo_offset;
vel_angulo += forca;
vel_angulo *= mola_amortecimento;
angulo_offset += vel_angulo;

escala_x = lerp(escala_x, 1, 0.15);
escala_y = lerp(escala_y, 1, 0.15);
image_xscale = escala_x;
image_yscale = escala_y;
#endregion

#region COMPORTAMENTO E MOVIMENTO
if (!assustado) {

    #region BALANCO ESTILO PONTEIRO
    tempo_balanco += vel_balanco;
    y += sin(tempo_balanco) * 0.3;
    image_angle = (sin(tempo_balanco) * angulo_maximo) + angulo_offset;
    #endregion

} else if (!eh_balao_bomba) {

    #region FUGA E MOVIMENTO DESCONTROLADO
    tempo_balanco += 0.4;
    image_angle = (sin(tempo_balanco) * 35) + angulo_offset;

    if (fase_fuga == 0) {
        vel_fuga_y = lerp(vel_fuga_y, 6, 0.15);
        vel_fuga_x = lerp(vel_fuga_x, 0, 0.1);
        
        timer_fuga += 1;
        if (timer_fuga >= 12) {
            fase_fuga = 1;
        }
    } else {
        vel_fuga_y = lerp(vel_fuga_y, -2, 0.08);
        vel_fuga_x = lerp(vel_fuga_x, direcao_fuga_x * 7, 0.1);
    }

    x += vel_fuga_x;
    y += vel_fuga_y;

    tempo_vida_fuga -= 1;
    if (tempo_vida_fuga <= 0) {
        image_alpha -= 0.1;
        if (image_alpha <= 0) {
            instance_destroy();
        }
    }
    #endregion

}
#endregion