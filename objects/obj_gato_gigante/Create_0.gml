event_inherited();

x = 239;
// pes do gato encostados no chao, qualquer que seja a altura da room
if (instance_exists(obj_chao)) {
    y = obj_chao.bbox_top - (sprite_get_height(sprite_index) - sprite_get_yoffset(sprite_index)) * image_yscale;
} else {
    y = room_height - 100;
}

max_vida = 15;
vida = max_vida;
nome_boss = "BORBOLETAS DO CAOS";
eh_boss_secundario = false;

timer_dano_continuo = game_get_speed(gamespeed_fps)*4; 
#region  POEIRA
tempo_poeira = 0;
intervalo_poeira = 1;
#endregion

vida_real = 3;
morto = false;

explosoes_criadas = false;

#region AVISO DO CHEFE
timer_aviso_max = game_get_speed(gamespeed_fps) * 4;
timer_aviso = timer_aviso_max;
texto_aviso = tr("PROTEJA O GATO DAS FADAS!");
#endregion

#region CORACOES
coracoes_max = vida_real;
coracao_quebra = array_create(coracoes_max, 0);
treme_coracao = 0;
flash_vermelho = 0;

levar_golpe = function() {
    if (morto || vida_real <= 0) return;
    vida_real--;
    coracao_quebra[vida_real] = 0.01;
    treme_coracao = 20;
    flash_vermelho = 1;
    tremer_tela(10);
    zoom_punch(0.1);
    tocar_som(snd_miau);
};

desenhar_coracao = function(_x, _y, _t, _cor, _a) {
    draw_set_color(_cor);
    draw_set_alpha(_a);
    draw_circle(_x - _t * 0.5, _y - _t * 0.25, _t * 0.55, false);
    draw_circle(_x + _t * 0.5, _y - _t * 0.25, _t * 0.55, false);
    draw_triangle(_x - _t * 1.02, _y - _t * 0.05, _x + _t * 1.02, _y - _t * 0.05, _x, _y + _t * 1.1, false);
};

desenhar_meio_coracao = function(_x, _y, _t, _lado, _cor, _a) {
    draw_set_color(_cor);
    draw_set_alpha(_a);
    draw_circle(_x + _lado * _t * 0.5, _y - _t * 0.25, _t * 0.55, false);
    draw_triangle(_x + _lado * _t * 1.02, _y - _t * 0.05, _x, _y - _t * 0.05, _x, _y + _t * 1.1, false);
};
#endregion

#region ONDAS
onda = 0;
timer_onda = game_get_speed(gamespeed_fps) * 4.5;
intervalo_onda = game_get_speed(gamespeed_fps) * 6;
onda_banner = 0;
#endregion