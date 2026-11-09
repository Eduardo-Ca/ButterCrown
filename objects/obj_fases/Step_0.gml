#region NOVA PARTIDA (distancia voltou pra zero)
if (global.distancia_percorrida < ultima_dist - 1) reiniciar_fases();
ultima_dist = global.distancia_percorrida;
#endregion

if (global.pausado) exit;

tempo++;

#region TROCA DE FASE
if (global.distancia_percorrida >= proxima_troca) {
    fase_index = (fase_index + 1) mod array_length(fases);
    numero_fase++;

    var _f = fases[fase_index];
    global.fase = _f.id;
    proxima_troca += _f.distancia;

    banner_timer = banner_max;
    banner_titulo = tr("FASE ") + string(numero_fase);
    banner_nome = _f.nome;
    banner_cor = _f.cor;
    tocar_som(snd_up);
}

alpha_praia = lerp(alpha_praia, (global.fase == "praia") ? 1 : 0, 0.02);
if (banner_timer > 0) banner_timer--;
#endregion

#region MOVIMENTO DO MAR E COQUEIROS
mar_offset += global.vel_mundo * 0.5;

var _cw = camera_get_view_width(view_camera[0]);
for (var i = 0; i < qtd_coqueiros; i++) {
    var c = coqueiros[i];
    c.x -= global.vel_mundo * 0.7;
    if (c.x < -80) {
        c.x = _cw + random_range(40, 300);
        c.esc = random_range(0.9, 1.3);
        c.flip = choose(-1, 1);
    }
}
#endregion