tempo++;
tempo_cena++;
barras = lerp(barras, 1, 0.05);
tremor = max(0, tremor - 0.8);
flash = max(0, flash - 0.04);

var _alvo_raios = 0;
if (cena_atual == total_cenas - 1) _alvo_raios = climax_feito ? 1 : 0.3;
raios_forca = lerp(raios_forca, _alvo_raios, 0.05);

#region SEGURAR ESC PARA PULAR
if (keyboard_check(vk_escape)) segurar_esc += 1 / 50;
else segurar_esc = max(0, segurar_esc - 0.05);

if (segurar_esc >= 1) {
    if (!instance_exists(obj_menu)) instance_create_layer(0, 0, "Instances", obj_menu);
    instance_destroy();
    exit;
}
#endregion

#region PARTICULAS DE CADA CENA
if (array_length(particulas) < 120) {
    switch (cena_atual) {
        case 0:
            if (random(1) < 0.06) array_push(particulas, { tipo: "borb", x: -20, y: random_range(gh * 0.1, gh * 0.65),
                vx: random_range(1, 2.5), vy: 0, vida: 900, cor: make_color_hsv(irandom(255), 160, 255), fase: random(10), tam: random_range(5, 9) });
            break;
        case 1:
            if (random(1) < 0.25) array_push(particulas, { tipo: "fumaca", x: random(gw), y: gh + 30,
                vx: random_range(-0.3, 0.3), vy: -random_range(0.5, 1.3), vida: 400, cor: make_color_rgb(90, 40, 130), fase: 0, tam: random_range(20, 50) });
            break;
        case 2:
            if (random(1) < 0.3) array_push(particulas, { tipo: "faisca", x: random(gw), y: random(gh * 0.8),
                vx: 0, vy: -0.3, vida: 60, cor: choose(c_aqua, c_fuchsia, c_white), fase: random(10), tam: random_range(1.5, 3) });
            break;
        case 3:
            if (random(1) < 0.3) array_push(particulas, { tipo: "ouro", x: random(gw), y: -10,
                vx: random_range(-0.5, 0.5), vy: random_range(1, 2.2), vida: 500, cor: choose(c_yellow, c_orange), fase: random(10), tam: random_range(2, 3.5) });
            break;
    }
}

for (var i = array_length(particulas) - 1; i >= 0; i--) {
    var p = particulas[i];
    p.vida--;
    p.fase += 0.2;
    switch (p.tipo) {
        case "borb":   p.x += p.vx; p.y += sin(p.fase * 0.3) * 1.2; break;
        case "fumaca": p.x += p.vx; p.y += p.vy; p.tam += 0.15; break;
        case "faisca": p.y += p.vy; break;
        case "ouro":
            p.x += p.vx + sin(p.fase * 0.2) * 0.3;
            p.y += p.vy;
            if (p.vy < 2) p.vy += 0.15;
            break;
    }
    if (p.vida <= 0 || p.x > gw + 40 || p.y > gh + 40 || p.y < -100) array_delete(particulas, i, 1);
}
#endregion

#region FADES ENTRE CENAS
if (fade_estado == -1) {
    fade_alpha -= 0.02;
    if (fade_alpha <= 0) { fade_alpha = 0; fade_estado = 0; }
    exit;
}

if (fade_estado == 2) {
    fade_alpha += 0.015;
    if (fade_alpha >= 1) {
        if (!instance_exists(obj_menu)) instance_create_layer(0, 0, "Instances", obj_menu);
        instance_destroy();
    }
    exit;
}

if (fade_estado == 1) {
    fade_alpha += 0.03;
    if (fade_alpha >= 1) {
        cena_atual++;
        iniciar_cena();
        fade_estado = -1;
    }
    exit;
}
#endregion

#region TEXTO LETRA POR LETRA (com pausas)
var _txt = textos[cena_atual];
var _len = string_length(_txt);

if (letra_index < _len) {
    if (pausa > 0) {
        pausa--;
    } else {
        letra_index = min(_len, letra_index + velocidade_texto);
        var _atual = floor(letra_index);

        if (_atual > letra_ant) {
            letra_ant = _atual;
            var _c = string_char_at(_txt, _atual);

            if (_c == "." || _c == "!" || _c == "?") pausa = 14;
            else if (_c == ",") pausa = 7;

            if (_c != " " && _atual mod 2 == 0) {
                var _pitch = (cena_atual >= 2) ? random_range(0.6, 0.8) : random_range(1.0, 1.3);
                audio_play_sound(snd_pulo, 1, false, 1, 0, _pitch);
            }
        }
    }
}
#endregion

#region CLIMAX: REI DO CAOS
if (cena_atual == total_cenas - 1 && !climax_feito && climax_ini != -1 && floor(letra_index) >= climax_ini) {
    climax_feito = true;
    tremor = 25;
    flash = 0.9;
    tocar_som(snd_explosao);
    repeat (40) {
        array_push(particulas, { tipo: "ouro", x: gw / 2, y: gh / 2 - 50,
            vx: random_range(-6, 6), vy: random_range(-7, 3), vida: 90,
            cor: choose(c_yellow, c_orange, c_white), fase: random(10), tam: random_range(2, 4) });
    }
}
#endregion

#region AVANCAR
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
    if (letra_index < _len) {
        letra_index = _len;
        letra_ant = _len;
        pausa = 0;
    } else {
        fade_estado = (cena_atual >= total_cenas - 1) ? 2 : 1;
    }
}
#endregion