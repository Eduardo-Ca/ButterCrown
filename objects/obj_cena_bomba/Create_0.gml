#region TEMPOS (frames a 60 fps)
T_SIRENE      = 90;
T_AVIOES      = 150;
T_AVIOES_FIM  = 720;
T_BOMBA       = 360;
T_CLARAO      = 720;
CLARAO_SEGURA = 90;
CLARAO_SOME   = 180;
T_TITULO      = 1020;
T_FIM         = 1260;
#endregion

#region AJUSTES
gw = display_get_gui_width();
gh = display_get_gui_height();
ESCURO_MAX = 0.55;
ALTURA_IMPULSO = 80;
ALTURA_ALTA = 310;
PULAO = -18;
#endregion

#region ESTADO
t = 0;
escuro = 0;
clarao = 0;
som_sirene = -1;
global.cena_bomba = true;
#endregion

#region MUSICA
musica_anterior = -1;
var _musicas = [snd_musica_tema_1, snd_musica_tema_2, snd_musica_tema_3];
for (var i = 0; i < 3; i++) {
    if (audio_is_playing(_musicas[i])) musica_anterior = _musicas[i];
}
audio_stop_sound(snd_musica_tema_1);
audio_stop_sound(snd_musica_tema_2);
audio_stop_sound(snd_musica_tema_3);
#endregion

#region AVIOES (so os distantes)
// ini = frames depois de T_AVIOES | y = fracao da altura | dir 1 = para direita
avioes = [
    { ini: 0,   dur: 300, y: 0.10, esc: 0.6, dir:  1, alpha: 0.50 },
    { ini: 40,  dur: 340, y: 0.16, esc: 0.45, dir: -1, alpha: 0.40 },
    { ini: 90,  dur: 280, y: 0.07, esc: 0.5, dir: -1, alpha: 0.45 },
    { ini: 140, dur: 320, y: 0.20, esc: 0.7, dir:  1, alpha: 0.55 },
    { ini: 190, dur: 260, y: 0.12, esc: 0.4, dir:  1, alpha: 0.35 },
    { ini: 230, dur: 220, y: 0.18, esc: 0.55, dir: -1, alpha: 0.45 }
];

desenhar_aviao = function(_x, _y, _e, _d, _a) {
    draw_set_color(c_black);
    draw_set_alpha(_a);

    var _xa = _x - 55 * _e * _d;
    var _xb = _x + 45 * _e * _d;
    draw_rectangle(min(_xa, _xb), _y - 5 * _e, max(_xa, _xb), _y + 5 * _e, false);
    draw_triangle(_xb, _y - 5 * _e, _xb, _y + 5 * _e, _x + 62 * _e * _d, _y, false);

    draw_triangle(_x + 12 * _e * _d, _y - 4 * _e, _x - 14 * _e * _d, _y - 4 * _e, _x - 30 * _e * _d, _y - 60 * _e, false);
    draw_triangle(_x + 12 * _e * _d, _y + 4 * _e, _x - 14 * _e * _d, _y + 4 * _e, _x - 30 * _e * _d, _y + 60 * _e, false);

    draw_triangle(_x - 42 * _e * _d, _y - 3 * _e, _x - 55 * _e * _d, _y - 3 * _e, _x - 62 * _e * _d, _y - 20 * _e, false);
    draw_triangle(_x - 42 * _e * _d, _y + 3 * _e, _x - 55 * _e * _d, _y + 3 * _e, _x - 62 * _e * _d, _y + 20 * _e, false);
};
#endregion

#region BOMBA (pontinho distante)
BOMBA_X = gw * 0.65;
BOMBA_Y_INICIO = gh * 0.05;
BOMBA_Y_FIM = gh * 0.62;
foco = 0;
#endregion

#region BORBOLETAS DISTANTES
borboletas_fundo = [];
#endregion