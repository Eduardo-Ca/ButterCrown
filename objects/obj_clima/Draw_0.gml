#region COPIA DO FUNDO
if (modo_fundo) {
    if (instance_exists(dono)) dono.desenhar_fundo();
    exit;
}
#endregion

var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);
var _sx = _vw / base_w;
var _sy = _vh / base_h;
ultima_cam_y = _cy;
ultima_cam_h = _vh;

#region CEU DO PERIODO (degrade)
if (ceu_alpha_topo > 0 || ceu_alpha_base > 0) {
    draw_primitive_begin(pr_trianglestrip);
    draw_vertex_color(_cx - 2,       _cy - 2,       ceu_cor_topo, ceu_alpha_topo);
    draw_vertex_color(_cx + _vw + 2, _cy - 2,       ceu_cor_topo, ceu_alpha_topo);
    draw_vertex_color(_cx - 2,       _cy + _vh + 2, ceu_cor_base, ceu_alpha_base);
    draw_vertex_color(_cx + _vw + 2, _cy + _vh + 2, ceu_cor_base, ceu_alpha_base);
    draw_primitive_end();
}
#endregion

#region TOM DO CLIMA
if (clima_alpha > 0) {
    draw_set_color(clima_cor);
    draw_set_alpha(clima_alpha);
    draw_rectangle(_cx - 2, _cy - 2, _cx + _vw + 2, _cy + _vh + 2, false);
}
#endregion

#region PARTICULAS
switch (global.clima) {
    case "chuva":
    case "tempestade":
        var _incl = (global.clima == "tempestade") ? 0.35 : 0.25;
        draw_set_color(make_color_rgb(200, 220, 255));
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            var _x = _cx + p.x * _sx;
            var _y = _cy + p.y * _sy;
            draw_set_alpha(p.alpha);
            draw_line_width(_x, _y, _x + p.comp * _incl * _sx, _y - p.comp * _sy, (0.6 + p.camada * 0.8) * _sx);
        }

        // respingos no chao
        for (var i = 0; i < array_length(respingos); i++) {
            var r = respingos[i];
            var _w = (1 + r.t * 0.6) * _sx;
            var _rx = _cx + r.x * _sx;
            var _ry = _cy + r.y * _sy;
            draw_set_alpha(0.6 * (1 - r.t / 10));
            draw_ellipse(_rx - _w, _ry - _w * 0.3, _rx + _w, _ry + _w * 0.3, true);
        }
        break;

    case "areia":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            var _x = _cx + p.x * _sx;
            var _y = _cy + p.y * _sy;
            draw_set_alpha(p.alpha);
            if (p.poeira) {
                draw_set_color(make_color_rgb(210, 160, 90));
                draw_circle(_x, _y, p.comp * 0.15 * _sx, false);
            } else {
                draw_set_color(make_color_rgb(250, 215, 140));
                draw_line_width(_x, _y, _x + p.comp * _sx, _y + sin(p.onda) * 1.5 * _sy, _sx);
            }
        }
        break;

    case "mistico":
        gpu_set_blendmode(bm_add);
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            var _x = _cx + p.x * _sx;
            var _y = _cy + p.y * _sy;
            var _pul = 1 + sin(tempo * 0.1 + p.osc) * 0.3;

            draw_set_color(p.cor);
            draw_set_alpha(p.alpha * 0.3);
            draw_circle(_x, _y, p.raio * 3 * _pul * _sx, false);

            draw_set_color(c_white);
            draw_set_alpha(p.alpha);
            draw_circle(_x, _y, p.raio * 0.8 * _sx, false);
        }
        gpu_set_blendmode(bm_normal);
        break;

    case "petalas":
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            var _x = _cx + p.x * _sx;
            var _y = _cy + p.y * _sy;
            var _vira = cos(degtorad(p.rot * 2)); // efeito de virar no ar
            var _comp = p.tam * 1.4 * _sx;
            var _larg = p.tam * 0.6 * _vira * _sx;

            var _x1 = _x + lengthdir_x(_comp, p.rot);
            var _y1 = _y + lengthdir_y(_comp, p.rot);
            var _x2 = _x - lengthdir_x(_comp, p.rot);
            var _y2 = _y - lengthdir_y(_comp, p.rot);
            var _x3 = _x + lengthdir_x(_larg, p.rot + 90);
            var _y3 = _y + lengthdir_y(_larg, p.rot + 90);
            var _x4 = _x - lengthdir_x(_larg, p.rot + 90);
            var _y4 = _y - lengthdir_y(_larg, p.rot + 90);

            draw_set_alpha(p.alpha);
            draw_set_color(p.cor);
            draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, false);
            draw_set_color(merge_color(p.cor, make_color_rgb(200, 80, 130), 0.3));
            draw_triangle(_x1, _y1, _x2, _y2, _x4, _y4, false);
        }
        break;
}
#endregion

#region RAIO E FLASH
if (raio_alpha > 0) {
    draw_set_color(c_white);
    draw_set_alpha(raio_alpha * 0.35);
    draw_rectangle(_cx - 2, _cy - 2, _cx + _vw + 2, _cy + _vh + 2, false);

    if (raio_alpha > 0.3 && array_length(raio_pontos) > 1) {
        gpu_set_blendmode(bm_add);
        for (var i = 1; i < array_length(raio_pontos); i++) {
            var _a = raio_pontos[i - 1];
            var _b = raio_pontos[i];
            var _ax = _cx + _a[0] * _sx, _ay = _cy + _a[1] * _sy;
            var _bx = _cx + _b[0] * _sx, _by = _cy + _b[1] * _sy;

            draw_set_alpha(raio_alpha);
            draw_set_color(make_color_rgb(150, 170, 255));
            draw_line_width(_ax, _ay, _bx, _by, 4 * _sx);
            draw_set_color(c_white);
            draw_line_width(_ax, _ay, _bx, _by, 1.5 * _sx);
        }
        gpu_set_blendmode(bm_normal);
    }
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);