#region Configuracao da Camera
celulas_horizontais_base = 12;
celulas_verticais_base = 8;

largura_cam_base = celulas_horizontais_base * global.tamanho_celula;
altura_cam_base = celulas_verticais_base * global.tamanho_celula;

zoom_atual = 1.0;
zoom_alvo = 1.0;

zoom_minimo = 0.5;
zoom_maximo_atual = 1.0;
velocidade_zoom = 0.5;
suavizacao = 0.15;
#endregion

#region Metodos do Zoom
function controlar_zoom_mouse() {
    if (mouse_wheel_up()) {
        zoom_alvo -= velocidade_zoom;
    }
    if (mouse_wheel_down()) {
        zoom_alvo += velocidade_zoom;
    }
    
    zoom_alvo = clamp(zoom_alvo, zoom_minimo, zoom_maximo_atual);
}

function expandir_zoom_maximo(_passos) {
    zoom_maximo_atual += _passos;
    zoom_alvo = zoom_maximo_atual;
}
#endregion