#region INICIALIZACAO E CHANCE
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
if (sorteio_clima < 20) {
    global.clima = "nenhum";
} else if (sorteio_clima < 40) {
    global.clima = "chuva";
} else if (sorteio_clima < 55) {
    global.clima = "areia";
} else if (sorteio_clima < 70) {
    global.clima = "tempestade";
} else if (sorteio_clima < 85) {
    global.clima = "mistico";
} else {
    global.clima = "petalas"; 
}
#endregion

#region CONFIGURACAO DAS NUVENS
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height() * 2;

qtd_nuvens = 9;
nuvens = array_create(qtd_nuvens);

for (var i = 0; i < qtd_nuvens; i++) {
    nuvens[i] = {
        x: random(gui_w + 400),
        y: random_range(20, gui_h * 0.4),
        subimg: irandom(2),
        escala: random_range(2.5, 4.0),
        vel: random_range(0.2, 0.6),
        alpha: random_range(0.2, 0.5)
    };
}
#endregion

#region CONFIGURACAO DOS CLIMAS
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

    case "petalas":
        qtd_particulas = 60;
        particulas = array_create(qtd_particulas);
        for (var i = 0; i < qtd_particulas; i++) {
            particulas[i] = {
                x: random(gui_w + 300),
                y: random(gui_h),
                tam_x: random_range(4, 8),
                tam_y: random_range(2, 5),
                vel_y: random_range(1.0, 2.2),
                vel_x: random_range(1.5, 3.0),
                oscilacao: random(pi * 2),
                rotacao: random(360),
                vel_rot: random_range(-2, 2),
                alpha: random_range(0.5, 0.9),
                cor: make_color_rgb(255, random_range(120, 180), random_range(180, 220)) // Variação de rosa
            };
        }
        break;
}
#endregion