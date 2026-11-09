draw_set_font(Font1);
if (variable_global_exists("pular_cutscene") && global.pular_cutscene) {
    global.pular_cutscene = false;
    instance_create_layer(0, 0, "Instances", obj_menu);
    instance_destroy();
    exit;
}

if (!audio_is_playing(snd_coral)) {
    audio_play_sound(snd_coral, 5, true);
}
#region CENAS
cena_atual = 0;
textos = [
    "Dizem que o simples bater de asas de uma borboleta pode causar um tornado do outro lado do mundo...",
    "No entanto, a desordem real exige um toque de poder muito mais sombrio...",
    "Minhas candidatas... Vocês foram escolhidas para espalhar o caos supremo por todo o multiverso!",
    "Aquele que causar a maior destruição e subir mais alto... herdará a Coroa e se tornará o REI DO CAOS!"
];
for (var i = 0; i < array_length(textos); i++) textos[i] = tr(textos[i]);
total_cenas = array_length(textos);

falantes = [tr("NARRADOR"), tr("NARRADOR"), "???", "???"];
cores_falante = [
    make_color_rgb(0, 255, 220), make_color_rgb(0, 255, 220),
    make_color_rgb(200, 90, 255), make_color_rgb(200, 90, 255)
];

// camera de cinema: zoom inicial/final e deslocamento de cada cena
kb = [
    { z0: 4.0, z1: 4.4, px: -25, py: -10 },
    { z0: 4.4, z1: 4.0, px:  25, py:   0 },
    { z0: 4.0, z1: 4.5, px:   0, py: -15 },
    { z0: 4.2, z1: 4.7, px:  10, py:  10 }
];

palavras_destaque = ["CAOS", "COROA", "REI", "SUPREMO", "SOMBRIO", "TORNADO", "MULTIVERSO", "CHAOS", "CROWN", "KING", "SUPREME", "DARKER", "MULTIVERSE"];
#endregion

#region TEXTO
caixa_w = 920;
caixa_h = 130;
letra_index = 0;
letra_ant = 0;
velocidade_texto = 0.45;
pausa = 0;
layout = [];
climax_ini = -1;

// separa o texto em linhas/palavras (pra palavras tremerem sem pular de linha)
montar_layout = function(_txt) {
    draw_set_font(Font1);
    var _larg_max = caixa_w - 80;
    var _palavras = string_split(_txt, " ");
    var _esp = string_width(" ");
    var _linhas = [];
    var _linha = [];
    var _w = 0;
    var _ini = 1;
    climax_ini = -1;

    for (var i = 0; i < array_length(_palavras); i++) {
        var _p = _palavras[i];
        if (_p == "") { _ini++; continue; }

        var _pw = string_width(_p);
        if (_w + _pw > _larg_max && array_length(_linha) > 0) {
            array_push(_linhas, { palavras: _linha, larg: _w - _esp });
            _linha = [];
            _w = 0;
        }

        var _limpa = string_upper(string_letters(_p));
        var _dest = array_contains(palavras_destaque, _limpa);
        var _ant = (i > 0) ? string_upper(string_letters(_palavras[i - 1])) : "";
        if ((_limpa == "DO" && _ant == "REI") || (_limpa == "OF" && _ant == "KING")) _dest = true;
        if ((_limpa == "REI" || _limpa == "KING") && climax_ini == -1) climax_ini = _ini;
        var _ouro = _dest && (_limpa == "COROA" || _limpa == "REI" || _limpa == "DO" || _limpa == "CROWN" || _limpa == "KING" || _limpa == "OF");

        array_push(_linha, { txt: _p, x: _w, ini: _ini, dest: _dest, ouro: _ouro });
        _w += _pw + _esp;
        _ini += string_length(_p) + 1;
    }
    if (array_length(_linha) > 0) array_push(_linhas, { palavras: _linha, larg: _w - _esp });
    return _linhas;
};

iniciar_cena = function() {
    layout = montar_layout(textos[cena_atual]);
    letra_index = 0;
    letra_ant = 0;
    pausa = 0;
    tempo_cena = 0;
    climax_feito = false;
};
#endregion

#region EFEITOS
gw = display_get_gui_width();
gh = display_get_gui_height();
tempo = 0;
tempo_cena = 0;
fade_alpha = 1;
fade_estado = -1;
barras = 0;
tremor = 0;
flash = 0;
raios_forca = 0;
climax_feito = false;
particulas = [];
segurar_esc = 0;
#endregion

iniciar_cena();