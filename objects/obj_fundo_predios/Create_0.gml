#region CONFIGURACAO DAS CAMADAS DE PREDIOS
var larg_tela = room_width;

if (view_enabled) {
    larg_tela = camera_get_view_width(view_camera[0]);
}

var base_y = room_height;
if (instance_exists(obj_chao)) {
    base_y = obj_chao.y - 120;
}

qtd_fundo = 12;
predios_fundo = array_create(qtd_fundo);

for (var i = 0; i < qtd_fundo; i++) {
    predios_fundo[i] = {
        x: random(larg_tela + 600),
        y: base_y+30,
        subimg: irandom_range(7, 10),
        escala_x: choose(1, -1) * random_range(1.0, 1.4),
        escala_y: random_range(1.0, 1.4),
        vel: 0.15,
        alpha: 1
    };
}

qtd_meio = 14;
predios_meio = array_create(qtd_meio);

for (var i = 0; i < qtd_meio; i++) {
    predios_meio[i] = {
        x: random(larg_tela + 600),
        y: base_y,
        subimg: irandom_range(4, 6),
        escala_x: choose(1, -1) * random_range(1.4, 1.8),
        escala_y: random_range(1.4, 1.8),
        vel: 0.28,
        alpha: 1
    };
}

qtd_frente = 18;
predios_frente = array_create(qtd_frente);

for (var i = 0; i < qtd_frente; i++) {
    predios_frente[i] = {
        x: random(larg_tela + 600),
        y: base_y-50,
        subimg: irandom_range(0, 3),
        escala_x: choose(1, -1) * random_range(1.8, 2.2),
        escala_y: random_range(1.8, 2.2),
        vel: 0.45,
        alpha: 1.0
    };
}
#endregion