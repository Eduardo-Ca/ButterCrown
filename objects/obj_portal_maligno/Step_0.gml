if (global.pausado) exit;
if (!instance_exists(obj_gato_gigante)) { instance_destroy(); exit; }
if (atraso > 0) { atraso--; exit; }

tempo++;
giro += 8;
escala = (tempo < duracao - 8) ? lerp(escala, 1, 0.15) : lerp(escala, 1.6, 0.3);
if (tempo == 1) tocar_som(snd_bolha);

if (tempo >= duracao) {
    instance_create_layer(x, y, "luz", obj_borboleta_maligna, { tipo: tipo });
    repeat (10) {
        var _p = instance_create_layer(x, y, "Instances", obj_poeira);
        _p.cor = cor;
        _p.direction = random(360);
        _p.speed = random_range(1.5, 3.5);
        _p.tamanho_original = random_range(1, 2);
    }
    instance_destroy();
}