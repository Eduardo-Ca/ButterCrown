global.pausado = false;
#region ANIMACAO
timer_loja += 0.05;
painel_escala = lerp(painel_escala, 1.0, 0.15);
aba_alpha = lerp(aba_alpha, 1, 0.25);

caos_exibido = lerp(caos_exibido, global.caos, 0.2);
if (abs(caos_exibido - global.caos) < 0.5) caos_exibido = global.caos;

if (flash_caos > 0) flash_caos--;
for (var i = 0; i < array_length(flash_row); i++) {
    if (flash_row[i] > 0) flash_row[i]--;
    if (shake_row[i] > 0) shake_row[i]--;
}
#endregion

#region ENTRADA
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _pronto = (painel_escala > 0.9);
var _clique = mouse_check_button_pressed(mb_left);

hover_aba = -1;
hover_item = -1;
hover_botao = -1;
hover_jogar = false;

if (_pronto) {

    #region ABAS
    var _qtd_abas = array_length(abas);
    var _tab_w = ((linha_x2 - linha_x1) - tab_gap * (_qtd_abas - 1)) / _qtd_abas;

    for (var i = 0; i < _qtd_abas; i++) {
        var _tx1 = linha_x1 + i * (_tab_w + tab_gap);
        if (point_in_rectangle(_mx, _my, _tx1, tab_y1, _tx1 + _tab_w, tab_y1 + tab_h)) {
            hover_aba = i;
            if (_clique && i != aba_atual) {
                aba_atual = i;
                aba_alpha = 0;
                tocar_som(snd_pulo);
            }
        }
    }

    var _troca = 0;
    if (keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_right)) _troca = 1;
    if (keyboard_check_pressed(ord("Q")) || keyboard_check_pressed(vk_left)) _troca = -1;

    if (_troca != 0) {
        aba_atual = (aba_atual + _troca + _qtd_abas) mod _qtd_abas;
        aba_alpha = 0;
        tocar_som(snd_pulo);
    }
    #endregion
    
	#region ITENS
    var _lista = abas[aba_atual].upgrades;
    var _total = array_length(_lista);
    var _max_rol = max(0, _total - max_visiveis);
    rolagem = clamp(rolagem, 0, _max_rol);

    var _rol = mouse_wheel_down() - mouse_wheel_up();
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) _rol = 1;
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) _rol = -1;

    if (_rol != 0) {
        var _nova = clamp(rolagem + _rol, 0, _max_rol);
        if (_nova != rolagem) {
            rolagem = _nova;
            aba_alpha = 0.4;
        }
    }

    var _qtd_vis = min(_total, max_visiveis);

    for (var j = 0; j < _qtd_vis; j++) {
        var _idx = rolagem + j;
        var _upg = _lista[_idx];
        var _ly1 = linhas_y1 + j * (linha_h + linha_gap);
        var _bx1 = linha_x2 - 120;
        var _bx2 = linha_x2 - 16;
        var _by1 = _ly1 + (linha_h - 38) / 2;
        var _by2 = _by1 + 38;

        if (point_in_rectangle(_mx, _my, linha_x1, _ly1, linha_x2, _ly1 + linha_h)) {
            hover_item = j;
        }

        if (point_in_rectangle(_mx, _my, _bx1, _by1, _bx2, _by2)) {
            hover_botao = j;

            if (_clique) {
                var _lvl = variable_global_get(_upg.nivel_global);
                var _preco = _upg.preco_base + (_lvl * _upg.esc);

                if (_lvl < _upg.max_lvl) {
                    if (global.caos >= _preco) {
                        global.caos -= _preco;
                        variable_global_set(_upg.nivel_global, _lvl + 1);
                        recalcular_status();
                        salvar_jogo();

                        flash_row[_idx] = 20;
                        flash_caos = 20;
                        tocar_som(snd_up);
                    } else {
                        shake_row[_idx] = 14;
                        tocar_som(snd_sem_energia);
                    }
                }
            }
        }
    }
    #endregion

    #region JOGAR
    if (point_in_rectangle(_mx, _my, jogar_x1, jogar_y1, jogar_x2, jogar_y2)) {
        hover_jogar = true;
    }

    if ((hover_jogar && _clique) || keyboard_check_pressed(vk_enter)) {
        global.vel_mundo = global.vel_inicial_atual;
        global.distancia_percorrida = 0;
        room_restart();
    }
    #endregion
}
#endregion