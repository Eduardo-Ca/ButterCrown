#region VARIAVEIS GLOBAIS DO MUNDO
global.caos_pontos = 0;
global.pausado = false;

#endregion

#region CONFIGURACOES VELOCIDADE MUNDO
global.vel_mundo = 4;
global.velocidade_maxima = 10;
global.vel_minima_parada = 0.2;
global.atrito_ar = 0.01;     
global.atrito_chao = 0.06;      
global.distancia_percorrida = 0;
#endregion

#region AUDIO / MUSICA TEMA

if (!audio_is_playing(snd_musica_tema_1)) {
    audio_play_sound(snd_musica_tema_2, 10, true);
}
#endregion