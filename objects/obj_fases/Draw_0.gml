#region DESENHO DA PRAIA
if (alpha_praia <= 0.01) exit;

var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _cw = camera_get_view_width(_cam);
var _ch = camera_get_view_height(_cam);

var _chao = instance_exists(obj_chao) ? obj_chao.bbox_top : room_height;
var _areia_topo = _chao - areia_altura;
var _horizonte = _chao - altura_mar;
if (_horizonte > _cy + _ch) exit; // mar fora da tela

var _x1 = _cx - 4;
var _x2 = _cx + _cw + 4;
var _W = _x2 - _x1;
var _alt = _areia_topo - _horizonte;
var _a = alpha_praia;

#region AGUA (degrade)
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(_x1, _horizonte,      mar_cor_longe, _a);
draw_vertex_color(_x2, _horizonte,      mar_cor_longe, _a);
draw_vertex_color(_x1, _areia_topo + 4, mar_cor_perto, _a);
draw_vertex_color(_x2, _areia_topo + 4, mar_cor_perto, _a);
draw_primitive_end();

draw_set_color(c_white);
draw_set_alpha(0.35 * _a);
draw_line_width(_x1, _horizonte, _x2, _horizonte, 2);
#endregion

#region ONDAS (perspectiva)
var _cor_onda = merge_color(mar_cor_longe, c_white, 0.5);
draw_set_color(_cor_onda);
for (var i = 0; i < qtd_ondas; i++) {
    var _f = (i + 1) / (qtd_ondas + 1);
    var _f2 = _f * _f;
    var _by = _horizonte + _alt * _f2;
    var _amp = 0.6 + _f2 * 2.5;
    var _freq = 0.06 - _f2 * 0.035;
    var _desl = mar_offset * (0.2 + _f2 * 0.8) + tempo * 0.6;

    draw_set_alpha(_a * (0.25 + _f2 * 0.4));
    var _px = _x1;
    var _py = _by + sin((_x1 + _desl) * _freq + i) * _amp;
    for (var _x = _x1 + 8; _x <= _x2; _x += 8) {
        var _ny = _by + sin((_x + _desl) * _freq + i) * _amp;
        if (sin((_x + _desl * 1.3) * 0.05 + i * 2) > -0.2) {
            draw_line_width(_px, _py, _x, _ny, 1 + _f2);
        }
        _px = _x;
        _py = _ny;
    }
}
#endregion

gpu_set_blendmode(bm_add);

#region BRILHOS NA AGUA
draw_set_color(c_white);
for (var i = 0; i < qtd_brilhos; i++) {
    var b = brilhos[i];
    var _bx = _x1 + (((b.x * _W - mar_offset * (0.3 + b.y * 0.7)) mod _W) + _W) mod _W;
    var _byy = _horizonte + _alt * b.y * b.y;
    var _br = max(0, sin(tempo * b.vel + b.fase));
    var _w = 1 + b.y * 3;
    draw_set_alpha(_a * _br * 0.8);
    draw_rectangle(_bx - _w, _byy, _bx + _w, _byy + 1, false);
}
#endregion

#region REFLEXO DO SOL / LUA
var _nublado = variable_global_exists("clima") && (global.clima == "chuva" || global.clima == "tempestade");
if (!_nublado && variable_global_exists("periodo")) {
    var _sx = _cx + _cw * ((global.periodo == "tarde") ? 0.72 : 0.81);
    var _cor_ref = make_color_rgb(255, 250, 220);
    if (global.periodo == "tarde") _cor_ref = make_color_rgb(255, 170, 90);
    if (global.periodo == "noite") _cor_ref = make_color_rgb(200, 210, 255);

    draw_set_color(_cor_ref);
    for (var k = 0; k <= 10; k++) {
        var _fk = k / 10;
        var _ry = _horizonte + 2 + _alt * _fk * _fk;
        var _rw = (4 + k * 2) * (0.6 + 0.4 * sin(tempo * 0.1 + k));
        draw_set_alpha(_a * 0.5 * (1 - _fk * 0.8));
        draw_rectangle(_sx - _rw, _ry, _sx + _rw, _ry + 1, false);
    }
}
#endregion

gpu_set_blendmode(bm_normal);

#region AREIA
var _mare = sin(tempo * 0.025) * 3;
var _espuma_y = _areia_topo + _mare;

draw_set_alpha(_a);
draw_rectangle_color(_x1, _espuma_y, _x2, _chao + 2, areia_molhada, areia_molhada, areia_seca, areia_seca, false);

draw_set_color(merge_color(areia_seca, c_black, 0.15));
for (var i = 0; i < qtd_pontos; i++) {
    var d = pontos_areia[i];
    var _dx = _x1 + (((d.x * _W - mar_offset * 1.4) mod _W) + _W) mod _W;
    var _dy = _espuma_y + 4 + d.y * max(0, _chao - _espuma_y - 6);
    draw_rectangle(_dx, _dy, _dx + 1, _dy + 1, false);
}
#endregion

#region ESPUMA DA BEIRA
draw_primitive_begin(pr_trianglestrip);
for (var _x = _x1; _x <= _x2 + 8; _x += 8) {
    var _o = sin((_x + mar_offset) * 0.08 + tempo * 0.05) * 1.5;
    draw_vertex_color(_x, _espuma_y - 4 + _o, c_white, 0);
    draw_vertex_color(_x, _espuma_y + 1 + _o, c_white, 0.85 * _a);
}
draw_primitive_end();
#endregion

#region COQUEIROS
for (var i = 0; i < qtd_coqueiros; i++) {
    var c = coqueiros[i];
    var _px = _cx + c.x;
    var _py = _chao - 2;
    var _bal = sin(tempo * 0.03 + c.fase);

    if (spr_coq != -1) {
        // SEU SPRITE (origem: Bottom Centre)
        draw_sprite_ext(spr_coq, 0, _px, _py, c.esc * c.flip, c.esc, _bal * 1.5, c_white, _a);
    } else {
        // COQUEIRO PROVISORIO POR CODIGO
        var _e = c.esc;
        var _tx = _px;
        var _ty = _py;
        for (var s = 1; s <= 8; s++) {
            var _t = s / 8;
            var _nx = _px + c.flip * (_t * _t * 14 + _bal * _t * 2) * _e;
            var _ny = _py - _t * 60 * _e;
            draw_set_color((s mod 2 == 0) ? make_color_rgb(120, 80, 40) : make_color_rgb(100, 65, 30));
            draw_set_alpha(_a);
            draw_line_width(_tx, _ty, _nx, _ny, (5 - _t * 2) * _e);
            _tx = _nx;
            _ty = _ny;
        }

        var _angs = [10, 45, 80, 110, 145, 175];
        for (var f = 0; f < array_length(_angs); f++) {
            var _ang = _angs[f] + _bal * 5;
            var _lx = _tx;
            var _ly = _ty;
            for (var j = 1; j <= 5; j++) {
                var _qx = _tx + lengthdir_x(j * 6 * _e, _ang);
                var _qy = _ty + lengthdir_y(j * 6 * _e, _ang) + j * j * 0.6 * _e;
                draw_set_color((f mod 2 == 0) ? make_color_rgb(40, 140, 60) : make_color_rgb(60, 170, 70));
                draw_line_width(_lx, _ly, _qx, _qy, (4 - j * 0.6) * _e);
                _lx = _qx;
                _ly = _qy;
            }
        }

        draw_set_color(make_color_rgb(90, 60, 30));
        draw_circle(_tx - 2 * _e, _ty + 3 * _e, 2 * _e, false);
        draw_circle(_tx + 2 * _e, _ty + 4 * _e, 2 * _e, false);
    }
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
#endregion