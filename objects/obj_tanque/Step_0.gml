event_inherited();


if (global.pausado) {
    image_speed = 0;
    exit;
}


if (destruindo) {
    image_speed = 0;
    tiros = [];
    exit;
}
image_speed = 0.5;
recuo = lerp(recuo, 0, 0.15);

#region CHAMAR HELICOPTEROS
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    timer_heli--;
    if (timer_heli <= 0) {
        timer_heli = irandom_range(heli_min, heli_max);

        if (instance_number(obj_helicoptero) < max_helicopteros) {
            var _hy = obj_borboleta.y;
            if (instance_exists(obj_chao)) _hy = min(_hy, obj_chao.bbox_top - 70);
            instance_create_layer(obj_borboleta.posicao_x_base + 420, _hy, "Instances", obj_helicoptero);
        }
    }
}
#endregion

#region ATUALIZAR TIROS
for (var i = array_length(tiros) - 1; i >= 0; i--) {
    var _t = tiros[i];
    _t.tempo++;

    #region MIRA PERSEGUE A BORBOLETA
    if (_t.tempo < duracao_tiro * trava_mira && instance_exists(obj_borboleta) && !obj_borboleta.morto) {
        _t.ax = obj_borboleta.x;
        _t.ay = obj_borboleta.y;
        if (instance_exists(obj_chao)) _t.ay = min(_t.ay, obj_chao.bbox_top - 20);

        var _resta = duracao_tiro - _t.tempo + 1;
        _t.vx = (_t.ax - _t.x) / _resta;
        _t.vy = (_t.ay - _t.y) / _resta - gravidade_tiro * (_resta + 1) / 2;
    }
    #endregion

    _t.vy += gravidade_tiro;
    _t.x += _t.vx;
    _t.y += _t.vy;

    if (_t.tempo mod 3 == 0) {
        var _f = instance_create_layer(_t.x, _t.y, "Instances", obj_poeira);
        _f.cor = c_gray;
        _f.tamanho_original = random_range(0.6, 1.1);
    }

    var _v = instance_nearest(_t.x, _t.y, obj_vento);
    if (_v != noone && point_distance(_t.x, _t.y, _v.x, _v.y) < 28) {
        instance_destroy(_v);
        explodir_tiro(_t.x, _t.y);
        array_delete(tiros, i, 1);
        continue;
    }

    var _raio = (_t.tempo >= duracao_tiro) ? raio_explosao : raio_acerto;

    if (instance_exists(obj_borboleta) && point_distance(_t.x, _t.y, obj_borboleta.x, obj_borboleta.y) < _raio) {
        atordoar_borboleta(tempo_sem_voar);
        explodir_tiro(_t.x, _t.y);
        array_delete(tiros, i, 1);
        continue;
    }

    if (_t.tempo >= duracao_tiro) {
        explodir_tiro(_t.x, _t.y);
        array_delete(tiros, i, 1);
    }
}
#endregion

if (!instance_exists(obj_borboleta) || obj_borboleta.morto) exit;

var _b = obj_borboleta;

#region MOVIMENTO
timer_troca--;
if (timer_troca <= 0) {
    timer_troca = irandom_range(60, 150);
    if (random(1) < 0.7) alvo_offset = random_range(dist_min, dist_max);
}

var _dx = (_b.posicao_x_base + alvo_offset) - x;
if (abs(_dx) > 1) {
    x += clamp(_dx, -vel_tanque, vel_tanque);
    if (_dx < 0) image_speed = -0.5;
}
#endregion

#region DISPARO
timer_tiro--;
if (timer_tiro <= 0) {
    timer_tiro = irandom_range(tiro_min, tiro_max);

    var _mx = x + MORTEIRO_X;
    var _my = y + MORTEIRO_Y;
    var _ax = _b.x;
    var _ay = _b.y;

    if (instance_exists(obj_chao)) _ay = min(_ay, obj_chao.bbox_top - 20);

    array_push(tiros, {
        x: _mx,
        y: _my,
        ax: _ax,
        ay: _ay,
        vx: (_ax - _mx) / duracao_tiro,
        vy: (_ay - _my) / duracao_tiro - gravidade_tiro * (duracao_tiro + 1) / 2,
        tempo: 0
    });

    recuo = 6;
    tocar_som(snd_golpe);
    tremer_tela(3);

    repeat (8) {
        var _p = instance_create_layer(_mx, _my, "Instances", obj_poeira);
        _p.cor = choose(c_gray, c_white, c_orange);
        _p.direction = random_range(60, 120);
        _p.speed = random_range(1, 3);
        _p.tamanho_original = random_range(1, 2);
    }
}
#endregion