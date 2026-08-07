randomise();
#region VARIAVEIS GLOBAIS DO MUNDO
global.caos_pontos = 0;
global.pausado = false;
global.clima = "";
global.periodo = "";
#endregion

#region CONFIGURACOES VELOCIDADE MUNDO
global.vel_mundo = 2;
global.velocidade_maxima = 5;
global.vel_minima_parada = 0.2;
global.atrito_ar = 0.01;     
global.atrito_chao = 0.06;      
global.distancia_percorrida = 0;
#endregion

#region AUDIO / MUSICA TEMA
if (!audio_is_playing(snd_musica_tema_1) && !audio_is_playing(snd_musica_tema_2) && !audio_is_playing(snd_musica_tema_3)) {
    var musica_sorteada = choose(snd_musica_tema_1, snd_musica_tema_2, snd_musica_tema_3);
    audio_play_sound(musica_sorteada, 10, true);
}
#endregion