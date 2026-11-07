#region MODO FUNDO (copia que desenha atras dos predios)
if (variable_global_exists("clima_criando_fundo") && global.clima_criando_fundo) {
    global.clima_criando_fundo = false;
    modo_fundo = true;
    dono = noone;
    exit;
}
modo_fundo = false;
#endregion

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

#region BASE (tudo em coordenadas da tela 576x324)
base_w = 576;
base_h = 324;
tempo = 0;
ultima_cam_y = camera_get_view_y(view_camera[0]);
ultima_cam_h = camera_get_view_height(view_camera[0]);
var _nublado = (global.clima == "chuva" || global.clima == "tempestade");
#endregion

#region CEU DO PERIODO
switch (global.periodo) {
    case "dia":
        ceu_cor_topo = make_color_rgb(255, 240, 200); ceu_alpha_topo = 0.12;
        ceu_cor_base = make_color_rgb(255, 255, 255); ceu_alpha_base = 0;
        nuvem_cor = c_white;
        break;
    case "tarde":
        ceu_cor_topo = make_color_rgb(255, 90, 80);   ceu_alpha_topo = 0.30;
        ceu_cor_base = make_color_rgb(255, 180, 90);  ceu_alpha_base = 0.14;
        nuvem_cor = make_color_rgb(255, 205, 180);
        break;
    default:
        ceu_cor_topo = make_color_rgb(5, 8, 35);      ceu_alpha_topo = 0.50;
        ceu_cor_base = make_color_rgb(40, 30, 90);    ceu_alpha_base = 0.28;
        nuvem_cor = make_color_rgb(90, 95, 140);
        break;
}
#endregion

#region TOM DO CLIMA
clima_cor = c_black;
clima_alpha = 0;
switch (global.clima) {
    case "chuva":      clima_cor = make_color_rgb(30, 50, 100);   clima_alpha = 0.15; nuvem_cor = merge_color(nuvem_cor, make_color_rgb(150, 155, 170), 0.7); break;
    case "tempestade": clima_cor = make_color_rgb(10, 10, 25);    clima_alpha = 0.28; nuvem_cor = merge_color(nuvem_cor, make_color_rgb(80, 85, 100), 0.8);   break;
    case "areia":      clima_cor = make_color_rgb(230, 150, 60);  clima_alpha = 0.20; break;
    case "mistico":    clima_cor = make_color_rgb(60, 20, 90);    clima_alpha = 0.18; nuvem_cor = merge_color(nuvem_cor, make_color_rgb(190, 160, 230), 0.5); break;
    case "petalas":    clima_cor = make_color_rgb(255, 180, 210); clima_alpha = 0.10; nuvem_cor = merge_color(nuvem_cor, make_color_rgb(255, 225, 240), 0.6); break;
}
#endregion

#region NUVENS
qtd_nuvens = _nublado ? 12 : 7;
nuvens = array_create(qtd_nuvens);
for (var i = 0; i < qtd_nuvens; i++) {
    nuvens[i] = {
        x: random_range(-100, base_w + 100),
        y: random_range(10, base_h * 0.45),
        subimg: irandom(2),
        escala: random_range(0.8, 1.6),
        vel: random_range(0.1, 0.35),
        alpha: _nublado ? random_range(0.7, 0.95) : random_range(0.5, 0.85)
    };
}
#endregion

#region ESTRELAS
qtd_estrelas = (global.periodo == "noite" && !_nublado) ? 45 : 0;
estrelas = array_create(qtd_estrelas);
for (var i = 0; i < qtd_estrelas; i++) {
    estrelas[i] = {
        x: random(base_w),
        y: random(base_h * 0.55),
        tam: random_range(0.5, 1.5),
        fase: random(pi * 2),
        vel: random_range(0.03, 0.08)
    };
}
#endregion

#region PARTICULAS DO CLIMA
nova_particula = function(_espalhar) {
    var _p = {};
    switch (global.clima) {
        case "chuva":
        case "tempestade":
            var _forte = (global.clima == "tempestade");
            _p.camada = random(1);
            _p.vel = (_forte ? random_range(10, 14) : random_range(7, 10)) * (0.7 + _p.camada * 0.5);
            _p.comp = (_forte ? 14 : 10) * (0.6 + _p.camada * 0.8);
            _p.alpha = 0.2 + _p.camada * 0.45;
            _p.x = random_range(-20, base_w + 120);
            _p.y = _espalhar ? random(base_h) : random_range(-40, -10);
            break;

        case "areia":
            _p.comp = random_range(6, 16);
            _p.vel = random_range(6, 12);
            _p.alpha = random_range(0.2, 0.5);
            _p.onda = random(pi * 2);
            _p.poeira = (random(1) < 0.3);
            _p.x = _espalhar ? random(base_w) : base_w + random(80);
            _p.y = random(base_h);
            break;

        case "mistico":
            _p.raio = random_range(1, 2.5);
            _p.vel_y = random_range(-0.6, -0.2);
            _p.osc = random(pi * 2);
            _p.alpha = random_range(0.4, 0.9);
            _p.cor = make_color_hsv(random_range(130, 220), 200, 255);
            _p.x = random(base_w);
            _p.y = _espalhar ? random(base_h) : base_h + random(20);
            break;

        case "petalas":
            _p.tam = random_range(2, 4);
            _p.vel_x = random_range(1, 2);
            _p.vel_y = random_range(0.5, 1.2);
            _p.osc = random(pi * 2);
            _p.rot = random(360);
            _p.vel_rot = random_range(-4, 4);
            _p.alpha = random_range(0.6, 1);
            _p.cor = make_color_rgb(255, irandom_range(140, 190), irandom_range(190, 225));
            _p.x = _espalhar ? random(base_w) : base_w + random(60);
            _p.y = _espalhar ? random(base_h) : random_range(-20, base_h * 0.6);
            break;
    }
    return _p;
};

switch (global.clima) {
    case "chuva":      qtd_particulas = 110; break;
    case "tempestade": qtd_particulas = 160; break;
    case "areia":      qtd_particulas = 120; break;
    case "mistico":    qtd_particulas = 45;  break;
    case "petalas":    qtd_particulas = 50;  break;
    default:           qtd_particulas = 0;   break;
}

particulas = array_create(qtd_particulas);
for (var i = 0; i < qtd_particulas; i++) {
    particulas[i] = nova_particula(true);
}

respingos = [];
#endregion

#region RAIOS (TEMPESTADE)
raio_alpha = 0;
raio_timer = irandom_range(120, 300);
raio_segundo = 0;
raio_pontos = [];

criar_raio = function() {
    raio_pontos = [];
    var _x = random_range(base_w * 0.2, base_w * 0.9);
    var _y = -5;
    var _fim = base_h * random_range(0.5, 0.8);
    array_push(raio_pontos, [_x, _y]);
    while (_y < _fim) {
        _x += random_range(-12, 12);
        _y += random_range(12, 22);
        array_push(raio_pontos, [_x, _y]);
    }
};
#endregion

#region DESENHO DO FUNDO (sol, lua, estrelas, aurora, nuvens)
desenhar_fundo = function() {
    var _cam = view_camera[0];
    var _cx = camera_get_view_x(_cam);
    var _cy = camera_get_view_y(_cam);
    var _vw = camera_get_view_width(_cam);
    var _vh = camera_get_view_height(_cam);
    var _sx = _vw / base_w;
    var _sy = _vh / base_h;
    var _nublado = (global.clima == "chuva" || global.clima == "tempestade");

    #region SOL / LUA
    if (!_nublado) {
        var _ax, _ay, _r, _cor, _brilho;
        switch (global.periodo) {
            case "dia":   _ax = 0.82; _ay = 0.16; _r = 14; _cor = make_color_rgb(255, 245, 190); _brilho = make_color_rgb(255, 220, 120); break;
            case "tarde": _ax = 0.72; _ay = 0.50; _r = 22; _cor = make_color_rgb(255, 160, 90);  _brilho = make_color_rgb(255, 100, 60);  break;
            default:      _ax = 0.80; _ay = 0.17; _r = 11; _cor = make_color_rgb(235, 235, 255); _brilho = make_color_rgb(150, 170, 255); break;
        }
        var _px = _cx + _vw * _ax;
        var _py = _cy + _vh * _ay;
        var _pulso = 1 + sin(tempo * 0.03) * 0.05;

        gpu_set_blendmode(bm_add);
        draw_set_color(_brilho);
        for (var k = 4; k >= 1; k--) {
            draw_set_alpha(0.07);
            draw_circle(_px, _py, _r * (1 + k * 0.6) * _pulso * _sx, false);
        }
        gpu_set_blendmode(bm_normal);

        draw_set_alpha(1);
        draw_set_color(_cor);
        draw_circle(_px, _py, _r * _sx, false);

        if (global.periodo == "noite") {
            draw_set_color(make_color_rgb(200, 200, 225));
            draw_circle(_px - 3 * _sx, _py - 2 * _sy, 2.5 * _sx, false);
            draw_circle(_px + 4 * _sx, _py + 3 * _sy, 1.8 * _sx, false);
            draw_circle(_px + 1 * _sx, _py - 5 * _sy, 1.2 * _sx, false);
        }
    }
    #endregion

    #region ESTRELAS
    if (qtd_estrelas > 0) {
        gpu_set_blendmode(bm_add);
        draw_set_color(c_white);
        for (var i = 0; i < qtd_estrelas; i++) {
            var _e = estrelas[i];
            draw_set_alpha(0.3 + 0.7 * abs(sin(tempo * _e.vel + _e.fase)));
            draw_circle(_cx + _e.x * _sx, _cy + _e.y * _sy, _e.tam * _sx, false);
        }
        gpu_set_blendmode(bm_normal);
    }
    #endregion

    #region AURORA (MISTICO)
    if (global.clima == "mistico") {
        gpu_set_blendmode(bm_add);
        for (var b = 0; b < 3; b++) {
            var _cor_a = make_color_hsv(120 + b * 30 + sin(tempo * 0.01) * 15, 200, 255);
            draw_primitive_begin(pr_trianglestrip);
            for (var _x = -16; _x <= base_w + 16; _x += 16) {
                var _y = base_h * 0.12 + b * 14 + sin(_x * 0.02 + tempo * 0.02 + b) * 10;
                draw_vertex_color(_cx + _x * _sx, _cy + (_y - 25) * _sy, _cor_a, 0);
                draw_vertex_color(_cx + _x * _sx, _cy + _y * _sy, _cor_a, 0.22);
            }
            draw_primitive_end();
        }
        gpu_set_blendmode(bm_normal);
    }
    #endregion

    #region NUVENS
    for (var i = 0; i < qtd_nuvens; i++) {
        var n = nuvens[i];
        draw_sprite_ext(spr_nuvem, n.subimg, _cx + n.x * _sx, _cy + n.y * _sy, n.escala * _sx, n.escala * _sy, 0, nuvem_cor, n.alpha);
    }
    #endregion

    draw_set_alpha(1);
    draw_set_color(c_white);
};
#endregion

#region CRIA A COPIA QUE DESENHA ATRAS DOS PREDIOS
global.clima_criando_fundo = true;
var _f = instance_create_depth(0, 0, 350, obj_clima);
_f.dono = id;
#endregion