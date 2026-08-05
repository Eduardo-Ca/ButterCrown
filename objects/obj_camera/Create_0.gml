#region Configuracao da Camera
celulas_horizontais_base = 10;
celulas_verticais_base = 6;

largura_cam_base = celulas_horizontais_base * global.tamanho_celula;
altura_cam_base = celulas_verticais_base * global.tamanho_celula;

zoom_atual = 1.0;
zoom_alvo = 1.0;

zoom_minimo = 0.5;

var _max_h = room_width / largura_cam_base;
var _max_v = room_height / altura_cam_base;
zoom_maximo_atual = min(_max_h, _max_v);

velocidade_zoom = 0.25;
suavizacao = 0.15;
#endregion

#region Metodos do Zoom
controlar_zoom_mouse = function() {
    if (mouse_wheel_up()) {
        zoom_alvo -= velocidade_zoom;
    }
    if (mouse_wheel_down()) {
        zoom_alvo += velocidade_zoom;
    }
    
    zoom_alvo = clamp(zoom_alvo, zoom_minimo, zoom_maximo_atual);
};

expandir_zoom_maximo = function(_passos) {
    zoom_maximo_atual += _passos;
    zoom_alvo = zoom_maximo_atual;
};
#endregion