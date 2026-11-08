#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion
if (global.cena_bomba) exit;

#region ALTURA DO CHAO
var _chao_y = instance_exists(obj_chao) ? obj_chao.bbox_top : room_height - 15;
#endregion

#region ATALHO DEBUG
if (keyboard_check_pressed(vk_f2)) exibir_debug_chances = !exibir_debug_chances;
#endregion

#region CHECAGEM E SPAWN DO BOSS
if (global.distancia_percorrida >= proximo_boss_distancia) {
    proximo_boss_distancia += intervalo_boss;

    var _boss_dados = lista_bosses[index_boss_atual % array_length(lista_bosses)];
    index_boss_atual += 1;

    var _alerta = instance_create_depth(0, 0, -9999, obj_alerta_boss);
    with (_alerta) {
        texto_titulo = _boss_dados.titulo;
        texto_subtitulo = _boss_dados.subtitulo;
    }

    var _cam_x = camera_get_view_x(view_camera[0]);
    var _cam_w = camera_get_view_width(view_camera[0]);
    if (_cam_w == 0) _cam_w = room_width;

    var _spawn_x = _cam_x + _cam_w + 100;

    var _lista_objs = _boss_dados.objetos;
    for (var j = 0; j < array_length(_lista_objs); j++) {
        var _obj_info = _lista_objs[j];
        var _off_x = variable_struct_exists(_obj_info, "offset_x") ? _obj_info.offset_x : 0;
        var _off_y = variable_struct_exists(_obj_info, "offset_y") ? _obj_info.offset_y : 0;

        instance_create_layer(_spawn_x + _off_x, _chao_y - _boss_dados.altura + _off_y, "Instances", _obj_info.objeto);
    }
}
#endregion

#region SPAWN NORMAL
if (instance_exists(obj_gato_gigante)) exit;
distancia_acumulada += global.vel_mundo;

if (distancia_acumulada >= proximo_espacamento) {
    distancia_acumulada = 0;

    var _dist = global.distancia_percorrida;
    var _fator_freq = global.spawn_freq_mult * (1 + _dist / 1500);
    proximo_espacamento = irandom_range(espacamento_min, espacamento_max) / _fator_freq;

    if (instance_number(obj_obstaculo) < max_obstaculos) {

        #region CALCULO DOS PESOS
        var _qtd = array_length(lista_spawns);
        var _pesos = array_create(_qtd, 0);
        var _total = 0;

        for (var i = 0; i < _qtd; i++) {
            var _item = lista_spawns[i];
            var _f = (_dist < _item.dist_min) ? 0 : clamp((_dist - _item.dist_min) / rampa_aparicao, 0.2, 1);

            var _mult = 1;
            switch (_item.categoria) {
                case "bonus":
                    _mult = global.chance_bonus_mult * (1 + sem_bonus * 0.15);
                    break;
                case "perigo":
                    _mult = global.chance_perigo_mult * (1 + _dist / 1500);
                    break;
            }

            if (variable_struct_exists(global.spawn_mult, _item.chave)) {
                _mult *= variable_struct_get(global.spawn_mult, _item.chave);
            }
			        
            if (variable_global_exists("fase") && global.fase == "praia" && _item.chave == "construcao") _mult = 0;
            _pesos[i] = _item.chance * _f * _mult;
            _total += _pesos[i];
        }

        debug_pesos = _pesos;
        debug_total = _total;
        #endregion

        #region SORTEIO
        if (_total > 0) {
            var _sorteio = random(_total);
            var _acumulado = 0;
            var _escolhido = lista_spawns[0];

            for (var i = 0; i < _qtd; i++) {
                _acumulado += _pesos[i];
                if (_pesos[i] > 0 && _sorteio <= _acumulado) {
                    _escolhido = lista_spawns[i];
                    break;
                }
            }

            if (_escolhido.categoria == "bonus") {
                sem_bonus = 0;
            } else {
                sem_bonus++;
            }
        #endregion

        #region CRIACAO
            var _pos_y = 0;
            if (_escolhido.alinhado_chao) {
                var _spr = object_get_sprite(_escolhido.objeto);
                var _metade_altura = (_spr != -1) ? (sprite_get_height(_spr) / 2) : 16;
                _pos_y = _chao_y - _metade_altura + 3;
            } else {
                _pos_y = _chao_y - irandom_range(_escolhido.alt_min, _escolhido.alt_max);
            }

            instance_create_depth(x, _pos_y, depth, _escolhido.objeto);
            #endregion
        }
    }
}
#endregion