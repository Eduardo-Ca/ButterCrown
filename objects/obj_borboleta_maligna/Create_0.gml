if (!variable_instance_exists(id, "tipo")) tipo = "normal";

cor = make_color_hsv(irandom(255), 255, 255);
vida = 1;
vel = 1.6;
escala_base = 1;
mira_max = 30;

switch (tipo) {
    case "rapida":
        cor = make_color_rgb(255, 60, 60);
        vel = 2.8;
        escala_base = 0.75;
        mira_max = 18;
        break;
    case "rainha":
        cor = make_color_rgb(255, 200, 60);
        vida = 2;
        vel = 1.1;
        escala_base = 1.8;
        mira_max = 40;
        break;
}

image_blend = cor;
image_xscale = -escala_base;
image_yscale = escala_base;

estado = "surgindo";     // surgindo -> voando -> mirando -> mergulho
timer_surgir = 45;
tempo = random(100);
dir = 180;
dist_mergulho = 90;
timer_mira = 0;
mergulho_dir = 0;
mergulho_vel = (tipo == "rapida") ? 7 : 6;
timer_mergulho = 0;
timer_rastro = 0;

flash = 0;
inv = 0;
morta_pelo_jogador = false;

#region LEVAR DANO
levar_dano = function() {
    if (inv > 0) return;
    vida--;
    flash = 1;
    inv = 10;

    if (vida <= 0) {
        morta_pelo_jogador = true;
        instance_destroy();
    } else {
        tocar_som(snd_golpe);
        tremer_tela(4);
        estado = "voando";
        x += 25;
    }
};
#endregion