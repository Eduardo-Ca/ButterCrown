if (global.pausado) exit;
if(instance_exists(obj_loja)){instance_destroy();};
t++;

#region SIRENE E ESCURIDAO
if (t == T_SIRENE) som_sirene = audio_play_sound(snd_sirene, 5, true);
if (t >= T_SIRENE && t < T_CLARAO) escuro = lerp(escuro, ESCURO_MAX, 0.01);
if (t == T_CLARAO) audio_stop_sound(som_sirene);
#endregion

#region CLARAO
if (t == T_CLARAO) {
    clarao = 1;
    tocar_som(snd_golpe);
    tremer_tela(15);
    zoom_punch(0.2);

    borboletas_fundo = [];
    instance_destroy(obj_obstaculo, false);

    with (obj_borboleta) {
        vel_vertical = other.PULAO;
        image_xscale = 0.4;
        image_yscale = 1.7;
    }
}
if (t > T_CLARAO + CLARAO_SEGURA) clarao = max(0, clarao - 1 / CLARAO_SOME);
if (t > T_CLARAO) escuro = lerp(escuro, 0, 0.03);
#endregion

#region BORBOLETA NAO CAI
global.vel_mundo = max(global.vel_mundo, global.velocidade_maxima * 0.6);

if (instance_exists(obj_chao)) {
    var _chao = obj_chao.bbox_top;
    var _altura = (t >= T_CLARAO) ? ALTURA_ALTA : ALTURA_IMPULSO;
    with (obj_borboleta) {
        if (!morto) {
            quiques_atuais = 0;
            if (vel_vertical > 0 && bbox_bottom > _chao - _altura) {
                vel_vertical = forca_impulso;
                image_xscale = 0.5;
                image_yscale = 1.5;
                tocar_som(snd_pulo);
            }
        }
    }
}
#endregion

#region BORBOLETAS DISTANTES
if (t < T_CLARAO && random(1) < 0.08) {
    array_push(borboletas_fundo, {
        x: gw + 20,
        y: random_range(gh * 0.08, gh * 0.5),
        vx: -random_range(1.5, 3.5),
        fase: random(10),
        esc: random_range(0.5, 1.1),
        cor: make_color_hsv(irandom(255), 60, 255)
    });
}

var _pressa = 1;
if (t >= T_BOMBA && t < T_CLARAO) _pressa = 1 + (t - T_BOMBA) / (T_CLARAO - T_BOMBA) * 1.5;

for (var i = array_length(borboletas_fundo) - 1; i >= 0; i--) {
    var _b = borboletas_fundo[i];
    _b.x += _b.vx * _pressa;
    _b.fase += 0.4;
    _b.y += sin(_b.fase * 0.3) * 0.8;
    if (_b.x < -40) array_delete(borboletas_fundo, i, 1);
}
#endregion

#region  BOMBA
if (t == T_BOMBA) {
    audio_play_sound(snd_musica_tema_4, 10, true);
}

if (t >= T_BOMBA && t < T_CLARAO) {
    var _p = (t - T_BOMBA) / (T_CLARAO - T_BOMBA);
    var _intervalo = round(lerp(60, 12, _p));
    if ((t - T_BOMBA) mod _intervalo == 0) {
        audio_play_sound(snd_golpe, 4, false, 0.25 + _p * 0.5, 0, 0.6);
        tremer_tela(1 + _p * 4);
    }
    foco = lerp(foco, 0.45, 0.01);
}
if (t >= T_CLARAO) foco = lerp(foco, 0, 0.05);
#endregion

#region TITULO E FIM
if (t == T_TITULO) {
    tocar_som(snd_estrela);
    tremer_tela(8);
}
if (t >= T_FIM) instance_destroy();
#endregion