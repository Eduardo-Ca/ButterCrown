randomise();
audio_stop_all();
draw_set_font(Font1);
#region AUDIO / MUSICA TEMA
if (!audio_is_playing(snd_musica_tema_1) && !audio_is_playing(snd_musica_tema_2) && !audio_is_playing(snd_musica_tema_3)) {
    var musica_sorteada = choose(snd_musica_tema_1, snd_musica_tema_2, snd_musica_tema_3);
    audio_play_sound(musica_sorteada, 10, true);
}
#endregion

#region MENU DE PAUSA
pausa_sel = 0;
pausa_opcoes = ["CONTINUAR", "MENU PRINCIPAL"];
pausa_esc = [1, 1];
pausa_w = 300;
pausa_h = 56;

pausa_y = function(_i) {
    return display_get_gui_height() / 2 + 10 + _i * 70;
};

pausa_acionar = function(_i) {
    tocar_som(snd_estrela);
    if (_i == 0) {
        global.pausado = false;
        mouse_clear(mb_left);
    } else {
        voltar_ao_menu();
    }
};
#endregion
