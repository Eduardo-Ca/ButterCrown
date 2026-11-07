if (modo_fundo) exit;

#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion

tempo++;

#region CHAO NA TELA (para os respingos)
var _sy = ultima_cam_h / base_h;
var _chao_tela = base_h + 50;
if (instance_exists(obj_chao)) {
    _chao_tela = (obj_chao.bbox_top - ultima_cam_y) / _sy;
}
#endregion

#region NUVENS
for (var i = 0; i < qtd_nuvens; i++) {
    var n = nuvens[i];
    n.x -= n.vel;
    if (n.x < -n.escala * 70) {
        n.x = base_w + n.escala * 70;
        n.y = random_range(10, base_h * 0.45);
        n.subimg = irandom(2);
        n.escala = random_range(0.8, 1.6);
        n.vel = random_range(0.1, 0.35);
    }
}
#endregion

#region PARTICULAS
for (var i = 0; i < qtd_particulas; i++) {
    var p = particulas[i];

    switch (global.clima) {
        case "chuva":
        case "tempestade":
            var _incl = (global.clima == "tempestade") ? 0.35 : 0.25;
            p.y += p.vel;
            p.x -= p.vel * _incl;

            var _limite = min(_chao_tela, base_h + 20);
            if (p.y >= _limite) {
                if (_chao_tela <= base_h && p.camada > 0.4) {
                    array_push(respingos, { x: p.x, y: _chao_tela, t: 0 });
                }
                particulas[i] = nova_particula(false);
            }
            break;

        case "areia":
            p.x -= p.vel;
            p.onda += 0.1;
            p.y += sin(p.onda) * 0.4;
            if (p.x < -20) particulas[i] = nova_particula(false);
            break;

        case "mistico":
            p.y += p.vel_y;
            p.osc += 0.03;
            p.x += sin(p.osc) * 0.3;
            if (p.y < -10) particulas[i] = nova_particula(false);
            break;

        case "petalas":
            p.osc += 0.05;
            p.x -= p.vel_x + sin(p.osc) * 0.6;
            p.y += p.vel_y;
            p.rot += p.vel_rot;
            if (p.x < -10 || p.y > base_h + 10) particulas[i] = nova_particula(false);
            break;
    }
}
#endregion

#region RESPINGOS
for (var i = array_length(respingos) - 1; i >= 0; i--) {
    respingos[i].t++;
    if (respingos[i].t > 10) array_delete(respingos, i, 1);
}
#endregion

#region RAIOS
if (global.clima == "tempestade") {
    raio_alpha = max(0, raio_alpha - 0.06);

    raio_timer--;
    if (raio_timer <= 0) {
        raio_timer = irandom_range(150, 420);
        raio_alpha = 1;
        raio_segundo = 7;
        criar_raio();
        tremer_tela(3);
    }

    if (raio_segundo > 0) {
        raio_segundo--;
        if (raio_segundo == 0) raio_alpha = 0.7;
    }
}
#endregion