function tocar_som(_som, _prioridade = 1, _loop = false) {
    if (!audio_is_playing(_som)) {
        audio_play_sound(_som, _prioridade, _loop);
    }
}

function criar_rastro_dash(_instancia, _taxa_desaparecer = 0.04, _taxa_encolher = 0.95, _cor = -1) {
    if (!instance_exists(_instancia) || !object_exists(obj_rastro)) exit;

    var rastro = instance_create_depth(_instancia.x, _instancia.y, _instancia.depth + 1, obj_rastro);

    rastro.sprite_index = _instancia.sprite_index;
    rastro.image_index = _instancia.image_index;
    rastro.image_xscale = _instancia.image_xscale;
    rastro.image_yscale = _instancia.image_yscale;
    rastro.image_angle = _instancia.image_angle;

    rastro.taxa_desaparecimento = _taxa_desaparecer;
    rastro.taxa_encolhimento = _taxa_encolher;

    if (_cor != -1) {
        rastro.image_blend = _cor;
    }
}
// criar_rastro_dash(id, 0.05, 0.9, c_aqua);

function criar_texto_flutuante(_x, _y, _texto, _cor = c_lime, _escala = 1.2) {
    var inst = instance_create_depth(_x, _y, -10000, obj_texto_flutuante);
    inst.texto = string(_texto);
    inst.cor = _cor;
    inst.escala = _escala;
    return inst;
}

//criar_texto_flutuante(x, y - 10, "+1", c_lime, 1.2);

function adicionar_log_cadeia(_texto, _tempo_duracao_segundos = 4) {
    array_push(global.logs_eventos, {
        texto: _texto,
        timer: _tempo_duracao_segundos * game_get_speed(gamespeed_fps)
    });
}
//adicionar_log_cadeia(other.nome + " acertou " + nome + ". Gerou " + string(pontos_caos) + " de caos.", 10);
