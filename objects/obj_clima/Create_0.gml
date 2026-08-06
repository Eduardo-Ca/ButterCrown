// Evento CREATE
#region INICIALIZACAO E CHANCES
if (variable_global_exists("clima") && global.clima != "") {
    instance_destroy();
    exit;
}

var sorteio_horario = random(100);
if (sorteio_horario < 40) {
    global.periodo = "dia";
} else if (sorteio_horario < 70) {
    global.periodo = "tarde";
} else {
    global.periodo = "noite";
}

var sorteio_clima = random(100);
if (sorteio_clima < 30) {
    global.clima = "nenhum";
} else if (sorteio_clima < 55) {
    global.clima = "chuva";
} else if (sorteio_clima < 75) {
    global.clima = "areia";
} else if (sorteio_clima < 92) {
    global.clima = "tempestade";
} else {
    global.clima = "mistico";
}
#endregion

#region CONFIGURACAO DOS CLIMAS
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height() * 2;

particulas = [];
raio_alpha = 0;

switch (global.clima) {
    case "chuva":
        qtd_particulas = 100;
        particulas = array_create(qtd_particulas);
        for (var i = 0; i < qtd_particulas; i++) {
            particulas[i] = {
                x: random(gui_w + 300),
                y: random(gui_h),
                tam: random_range(12, 24),
                vel: random_range(12, 18),
                alpha: random_range(0.3, 0.7)
            };
        }
        break;

    case "areia":
        qtd_particulas = 120;
        particulas = array_create(qtd_particulas);
        for (var i = 0; i < qtd_particulas; i++) {
            particulas[i] = {
                x: random(gui_w + 300),
                y: random(gui_h),
                tam: random_range(10, 24),
                vel: random_range(15, 25),
                alpha: random_range(0.2, 0.5)
            };
        }
        break;

    case "tempestade":
        qtd_particulas = 70;
        particulas = array_create(qtd_particulas);
        for (var i = 0; i < qtd_particulas; i++) {
            particulas[i] = {
                x: random(gui_w + 200),
                y: random(gui_h),
                tam: random_range(10, 18),
                vel: random_range(11, 16),
                alpha: random_range(0.2, 0.5)
            };
        }
        break;

    case "mistico":
        qtd_particulas = 50;
        particulas = array_create(qtd_particulas);
        for (var i = 0; i < qtd_particulas; i++) {
            particulas[i] = {
                x: random(gui_w),
                y: random(gui_h),
                raio: random_range(2, 5),
                vel_y: random_range(-0.8, -0.2),
                oscilacao: random(pi * 2),
                alpha: random_range(0.3, 0.8),
                cor: make_color_hsv(random_range(130, 200), 255, 255)
            };
        }
        break;
}
#endregion