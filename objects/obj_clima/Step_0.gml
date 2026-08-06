#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion

#region ATUALIZACAO DAS NUVENS
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height() * 2;

for (var i = 0; i < qtd_nuvens; i++) {
    var n = nuvens[i];
    n.x -= n.vel;
    
    if (n.x < -300) {
        n.x = gui_w + 300;
        n.y = random_range(20, gui_h * 0.4);
        n.subimg = irandom(2);
        n.escala = random_range(2.5, 4.0);
        n.vel = random_range(0.2, 0.6);
        n.alpha = random_range(0.2, 0.5);
    }
}
#endregion

#region ATUALIZACAO DO CLIMA
switch (global.clima) {
    case "chuva":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            p.y += p.vel;
            p.x -= p.vel * 0.25;
            if (p.y > gui_h) {
                p.y = -20;
                p.x = random(gui_w + 300);
            }
        }
        break;

    case "areia":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            p.x -= p.vel;
            p.y += random_range(-0.5, 0.5);
            if (p.x < -20) {
                p.x = gui_w + 300;
                p.y = random(gui_h);
            }
        }
        break;

    case "tempestade":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            p.y += p.vel;
            p.x -= p.vel * 0.2;
            if (p.y > gui_h) {
                p.y = -10;
                p.x = random(gui_w + 200);
            }
        }
        if (raio_alpha > 0) {
            raio_alpha -= 0.05;
        } else if (random(300) < 1) { 
            raio_alpha = random_range(0.6, 0.9);
        }
        break;

    case "mistico":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            p.y += p.vel_y;
            p.oscilacao += 0.03;
            p.x += sin(p.oscilacao) * 0.6;
            
            if (p.y < -20) {
                p.y = gui_h + 20;
                p.x = random(gui_w);
            }
        }
        break;
}
#endregion