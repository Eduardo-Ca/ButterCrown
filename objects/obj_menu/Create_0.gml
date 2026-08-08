#region CONFIGURACOES E AUDIO
audio_stop_all();
if (!audio_is_playing(snd_musica_tema_1)) {
    audio_play_sound(snd_musica_tema_1, 10, true);
}

opcao_hover = -1;
mostrar_controles = false;

timer_tempo = 0;
start_escala = 1.0;
ctrl_escala = 1.0;
painel_escala = 0.0;

cor_cyan = make_color_rgb(0, 255, 255);

qtd_estrelas = 60;
estrelas = array_create(qtd_estrelas);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

for (var i = 0; i < qtd_estrelas; i++) {
    estrelas[i] = {
        x: random(gui_w),
        y: random(gui_h),
        vel_y: random_range(2, 6),
        vel_x: random_range(-0.5, -1.5),
        tamanho: random_range(1, 3),
        alpha: random_range(0.3, 0.9)
    };
}
#endregion