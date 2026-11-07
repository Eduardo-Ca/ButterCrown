#region ZOOM
zoom_impacto = lerp(zoom_impacto, 0, 0.12);
if (abs(zoom_impacto) < 0.001) zoom_impacto = 0;

var _prop_vel = (global.velocidade_maxima > 0) ? clamp(global.vel_mundo / global.velocidade_maxima, 0, 1) : 0;
var _morta = instance_exists(obj_borboleta) && obj_borboleta.morto;
var _alvo_zoom = _morta ? zoom_morte : 1 + _prop_vel * zoom_velocidade;
zoom_base = lerp(zoom_base, _alvo_zoom, _morta ? 0.06 : 0.03);

var _zoom = zoom_base - zoom_impacto;
var _w = largura_base * _zoom;
var _h = altura_base * _zoom;

x += (view_w_atual - _w) / 2;
y += (view_h_atual - _h) / 2;
view_w_atual = _w;
view_h_atual = _h;

camera_set_view_size(view_camera[0], _w, _h);
if (global.pausado) camera_set_view_pos(view_camera[0], x, y);
#endregion

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

    var pos_x_desejada = (alvo_x_final - (view_w_atual / 2)) + offset_shake_x;
    var pos_y_desejada = (alvo_y_final - (view_h_atual / 2)) + offset_shake_y;

    x = lerp(x, pos_x_desejada, 0.15);
    y = lerp(y, pos_y_desejada, 0.15);

    camera_set_view_pos(view_camera[0], x, y);
}
#endregion