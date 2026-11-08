if (atraso > 0) exit;

var _r = tamanho * escala;
var _pul = 1 + sin(tempo * 0.3) * 0.08;

// centro escuro
draw_set_color(make_color_rgb(20, 0, 30));
draw_set_alpha(0.85);
draw_circle(x, y, _r * 0.7 * _pul, false);

gpu_set_blendmode(bm_add);
draw_set_color(cor);

// brilho
draw_set_alpha(0.25);
draw_circle(x, y, _r * 1.4 * _pul, false);

// aneis tracejados girando
draw_set_alpha(0.9);
for (var k = 0; k < 2; k++) {
    var _rr = _r * (0.8 + k * 0.35);
    var _sent = (k == 0) ? 1 : -1;
    for (var s = 0; s < 12; s++) {
        var _a1 = giro * _sent + s * 30;
        var _a2 = _a1 + 18;
        draw_line_width(x + lengthdir_x(_rr, _a1), y + lengthdir_y(_rr, _a1),
                        x + lengthdir_x(_rr, _a2), y + lengthdir_y(_rr, _a2), 2);
    }
}

// faiscas sendo sugadas
for (var s = 0; s < 6; s++) {
    var _f = frac(tempo * 0.03 + s / 6);
    var _d = _r * 2.2 * (1 - _f);
    var _a = s * 60 + tempo * 3;
    draw_set_alpha(_f);
    draw_circle(x + lengthdir_x(_d, _a), y + lengthdir_y(_d, _a), 1.5, false);
}

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);