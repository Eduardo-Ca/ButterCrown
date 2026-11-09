#region TUTORIAL
function concluir_tutorial() {
    global.tutorial_concluido = true;
    salvar_jogo();
}
#endregion

#region SAVE
#macro SAVE_ARQUIVO "save.json"
#macro SAVE_TEMP "save.tmp"

function save_niveis() {
    return [
        "upg_energia_nivel", "upg_impulso_nivel", "upg_quiques_nivel", "upg_boost_nivel",
        "upg_limite_vel_nivel", "upg_vel_inicial_nivel", "upg_balao_nivel", "upg_pessoa_nivel",
        "upg_predio_nivel", "upg_perigo_nivel",
        "hab_meteoro_nivel", "hab_dobra_nivel", "hab_sapo_nivel", "hab_tornado_nivel"
    ];
}

function salvar_jogo() {
    var _dados = {
        versao: 1,
        caos: global.caos,
        recorde: global.recorde_distancia,
        tutorial: global.tutorial_concluido,
        niveis: {}
    };

    var _nomes = save_niveis();
    for (var i = 0; i < array_length(_nomes); i++) {
        _dados.niveis[$ _nomes[i]] = variable_global_get(_nomes[i]);
    }

    var _buf = buffer_create(1, buffer_grow, 1);
    buffer_write(_buf, buffer_string, json_stringify(_dados));
    buffer_save(_buf, SAVE_TEMP);
    buffer_delete(_buf);

    if (file_exists(SAVE_ARQUIVO)) file_delete(SAVE_ARQUIVO);
    file_rename(SAVE_TEMP, SAVE_ARQUIVO);
}

function save_existe() {
    return file_exists(SAVE_ARQUIVO) || file_exists(SAVE_TEMP);
}

function apagar_progresso() {
    if (file_exists(SAVE_ARQUIVO)) file_delete(SAVE_ARQUIVO);
    if (file_exists(SAVE_TEMP)) file_delete(SAVE_TEMP);

    global.caos = 0;
    global.recorde_distancia = 0;
    global.tutorial_concluido = false;

    var _nomes = save_niveis();
    for (var i = 0; i < array_length(_nomes); i++) {
        variable_global_set(_nomes[i], 0);
    }

    recalcular_status();
    global.vel_mundo = global.vel_inicial_atual;
}

function voltar_ao_menu() {
    salvar_jogo();
    global.pular_cutscene = true;
    global.pausado = false;
    audio_stop_all();
    room_goto(menu);
}

function carregar_jogo() {
    var _arq = file_exists(SAVE_ARQUIVO) ? SAVE_ARQUIVO : SAVE_TEMP;
    if (!file_exists(_arq)) return false;

    var _dados = undefined;
    try {
        var _buf = buffer_load(_arq);
        var _txt = buffer_read(_buf, buffer_string);
        buffer_delete(_buf);
        _dados = json_parse(_txt);
    } catch (_erro) {
        show_debug_message("Save invalido: " + string(_erro));
        return false;
    }

    if (!is_struct(_dados)) return false;

    if (is_real(_dados[$ "caos"])) global.caos = max(0, _dados.caos);
    if (is_real(_dados[$ "recorde"])) global.recorde_distancia = max(0, _dados.recorde);
    if (!is_undefined(_dados[$ "tutorial"])) global.tutorial_concluido = bool(_dados.tutorial);

    var _niveis = _dados[$ "niveis"];
    if (is_struct(_niveis)) {
        var _nomes = save_niveis();
        for (var i = 0; i < array_length(_nomes); i++) {
            var _v = _niveis[$ _nomes[i]];
            if (is_real(_v)) variable_global_set(_nomes[i], max(0, floor(_v)));
        }
    }
    return true;
}
#endregion
