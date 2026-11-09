if (global.pausado) exit;

if (vida <= 0 && !explosoes_criadas) {
    explosoes_criadas = true;
    repeat (3) {
        tocar_som(snd_miau);
        instance_create_depth(x + irandom_range(-55, 55), y + irandom_range(-55, 55), depth - 20, obj_explosao_som);
    }
}
event_inherited();

#region VISUAL DOS CORACOES E DANO
for (var i = 0; i < coracoes_max; i++) {
    if (coracao_quebra[i] > 0 && coracao_quebra[i] < 1) {
        coracao_quebra[i] = min(1, coracao_quebra[i] + 0.03);
    }
}
if (treme_coracao > 0) treme_coracao--;
flash_vermelho = max(0, flash_vermelho - 0.05);
image_blend = merge_color(c_white, c_red, flash_vermelho);
if (onda_banner > 0) onda_banner--;
#endregion

if (vida_real <= 0) {
    if (!morto) {
		repeat(2){
			instance_create_depth(x, y, depth - 20, obj_explosao_som);
		}		
        image_index = 0;
        sprite_index = spr_gato_gigante_morrendo;
        morto = true;
        matar_borboleta();
    }
} else {

    #region POEIRA NAS PATAS
    tempo_poeira--;
    if (tempo_poeira <= 0) {
        tempo_poeira = intervalo_poeira;
        var _offset_x = choose(true, false) ? random_range(-140, -110) : random_range(20, 50);
        var _pos_x = x + (_offset_x * image_xscale);
        var _pos_y = y + random_range(70, 80);
        instance_create_layer(_pos_x - 60, _pos_y, "controles", obj_poeira);
    }
    #endregion

    #region TIMER DA BARRA (SOBREVIVA)
    timer_dano_continuo--;
    if (timer_dano_continuo <= 0) {
        timer_dano_continuo = game_get_speed(gamespeed_fps) * 3;
        tomar_dano(1);
    }
    #endregion

    #region ONDAS DE BORBOLETAS DO MAL
    if (!destruindo) {
        timer_onda--;
        if (timer_onda <= 0) {
            onda++;
            onda_banner = 90;
            timer_onda = max(game_get_speed(gamespeed_fps) * 3.5, intervalo_onda - onda * 15);

            var _qtd = min(2 + floor(onda / 2), 5);
            var _cam = view_camera[0];
            var _cx = camera_get_view_x(_cam);
            var _cy = camera_get_view_y(_cam);
            var _cw = camera_get_view_width(_cam);
            var _ch = camera_get_view_height(_cam);

            for (var i = 0; i < _qtd; i++) {
                var _tipo = "normal";
                if (onda >= 4 && random(1) < 0.35) _tipo = "rapida";
                if (onda >= 5 && onda mod 2 == 1 && i == 0) _tipo = "rainha";

				var _px = clamp(x + random_range(240, 340), _cx + _cw * 0.5, _cx + _cw - 25);
				var _py = y - random_range(500, 600);
                instance_create_layer(_px, _py-60, "luz", obj_portal_maligno, { tipo: _tipo, atraso: i * 12 });
            }
        }
    }
    #endregion

    instance_destroy(obj_obstaculo);
}

#region TEMPO DO AVISO
if (timer_aviso > 0) timer_aviso--;
#endregion