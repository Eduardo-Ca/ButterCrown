event_inherited();

x = 239;
// pes do gato encostados no chao, qualquer que seja a altura da room
if (instance_exists(obj_chao)) {
    y = obj_chao.bbox_top - (sprite_get_height(sprite_index) - sprite_get_yoffset(sprite_index)) * image_yscale;
} else {
    y = room_height - 100;
}

max_vida = 30;
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
texto_aviso = "PROTEJA O GATO DAS FADAS!";
#endregion