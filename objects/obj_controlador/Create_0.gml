randomise();
audio_stop_all();
draw_set_font(Font1);
#region AUDIO / MUSICA TEMA
if (!audio_is_playing(snd_musica_tema_1) && !audio_is_playing(snd_musica_tema_2) && !audio_is_playing(snd_musica_tema_3)) {
    var musica_sorteada = choose(snd_musica_tema_1, snd_musica_tema_2, snd_musica_tema_3);
    audio_play_sound(musica_sorteada, 10, true);
}
#endregion

surface_resize(application_surface, 576, 324);
display_set_gui_size(1280, 720);

