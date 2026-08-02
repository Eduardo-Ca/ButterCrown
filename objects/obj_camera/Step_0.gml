#region Atualizacao da Camera
controlar_zoom_mouse();

zoom_atual = lerp(zoom_atual, zoom_alvo, suavizacao);

var _passo_zoom_suave = round(zoom_atual * 2) / 2;

var _celulas_h = round(celulas_horizontais_base * _passo_zoom_suave);
var _celulas_v = round(celulas_verticais_base * _passo_zoom_suave);

var _nova_largura = _celulas_h * global.tamanho_celula;
var _nova_altura = _celulas_v * global.tamanho_celula;

camera_set_view_size(view_camera[0], _nova_largura, _nova_altura);

var _centro_castelo_x = obj_castelo.x + (global.tamanho_celula / 2);
var _centro_castelo_y = obj_castelo.y + (global.tamanho_celula / 2);

var _cam_x = _centro_castelo_x - (_nova_largura / 2);
var _cam_y = _centro_castelo_y - (_nova_altura / 2);

_cam_x = floor(_cam_x / global.tamanho_celula) * global.tamanho_celula;
_cam_y = floor(_cam_y / global.tamanho_celula) * global.tamanho_celula;

camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
#endregion