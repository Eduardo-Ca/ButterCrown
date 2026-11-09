draw_set_font(Font1);
draw_clear_alpha(c_black, 1);

var _shx = random_range(-1, 1) * tremor * 0.4;
var _shy = random_range(-1, 1) * tremor * 0.4;

#region CAMERA DE CINEMA
var _k = kb[cena_atual];
var _t = clamp(tempo_cena / 600, 0, 1);
_t = _t * _t * (3 - 2 * _t);
var _z = lerp(_k.z0, _k.z1, _t);
var _ix = gw / 2 + _k.px * _t + _shx;
var _iy = gh / 2 - 50 + _k.py * _t + _shy;
#endregion

#region RAIOS DOURADOS (cena final)
if (raios_forca > 0.01) {
    gpu_set_blendmode(bm_add);
    draw_set_alpha(raios_forca * 0.5);
    for (var r = 0; r < 16; r++) {
        var _a1 = tempo * 0.4 + r * 22.5;
        var _a2 = _a1 + 9;
        draw_triangle_color(_ix, _iy,
            _ix + lengthdir_x(gw, _a1), _iy + lengthdir_y(gw, _a1),
            _ix + lengthdir_x(gw, _a2), _iy + lengthdir_y(gw, _a2),
            c_yellow, c_black, c_black, false);
    }
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}
#endregion

#region IMAGEM
if (sprite_exists(spr_entrada)) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_entrada, cena_atual, _ix, _iy, _z * 1.03, _z * 1.03, 0, make_color_rgb(80, 50, 120), 0.25);
    gpu_set_blendmode(bm_normal);
    draw_sprite_ext(spr_entrada, cena_atual, _ix, _iy, _z, _z, 0, c_white, 1);
}

if (cena_atual == 1) {
    draw_set_color(make_color_rgb(40, 0, 60));
    draw_set_alpha(0.25);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}
#endregion

#region PARTICULAS
for (var i = 0; i < array_length(particulas); i++) {
    var p = particulas[i];
    var _a = min(1, p.vida / 30);
    switch (p.tipo) {
        case "borb":
            var _asa = abs(sin(p.fase)) * p.tam;
            draw_set_color(p.cor);
            draw_set_alpha(0.9 * _a);
            draw_ellipse(p.x - _asa, p.y - p.tam * 0.6, p.x, p.y + p.tam * 0.2, false);
            draw_ellipse(p.x, p.y - p.tam * 0.6, p.x + _asa, p.y + p.tam * 0.2, false);
            draw_set_color(c_black);
            draw_line_width(p.x, p.y - p.tam * 0.5, p.x, p.y + p.tam * 0.3, 1.5);
            break;

        case "fumaca":
            draw_set_color(p.cor);
            draw_set_alpha(0.12 * min(1, p.vida / 100));
            draw_circle(p.x, p.y, p.tam, false);
            break;

        case "faisca":
            gpu_set_blendmode(bm_add);
            draw_set_color(p.cor);
            draw_set_alpha(abs(sin(p.fase * 0.5)) * _a);
            draw_line_width(p.x - p.tam * 2, p.y, p.x + p.tam * 2, p.y, 1);
            draw_line_width(p.x, p.y - p.tam * 2, p.x, p.y + p.tam * 2, 1);
            draw_circle(p.x, p.y, p.tam * 0.6, false);
            gpu_set_blendmode(bm_normal);
            break;

        case "ouro":
            gpu_set_blendmode(bm_add);
            draw_set_color(p.cor);
            draw_set_alpha(_a);
            draw_circle(p.x, p.y, p.tam, false);
            gpu_set_blendmode(bm_normal);
            break;
    }
}
draw_set_alpha(1);
#endregion

#region VINHETA
var _L = -300;
var _R = gw + 300;
var _vs = 180;
var _va = 0.7;
draw_primitive_begin(pr_trianglestrip); // topo
draw_vertex_color(_L, 0, c_black, _va); draw_vertex_color(_R, 0, c_black, _va);
draw_vertex_color(_L, _vs, c_black, 0); draw_vertex_color(_R, _vs, c_black, 0);
draw_primitive_end();
draw_primitive_begin(pr_trianglestrip); // baixo
draw_vertex_color(_L, gh - _vs, c_black, 0); draw_vertex_color(_R, gh - _vs, c_black, 0);
draw_vertex_color(_L, gh, c_black, _va); draw_vertex_color(_R, gh, c_black, _va);
draw_primitive_end();
draw_primitive_begin(pr_trianglestrip); // esquerda
draw_vertex_color(_L, 0, c_black, 0.9); draw_vertex_color(_vs, 0, c_black, 0);
draw_vertex_color(_L, gh, c_black, 0.9); draw_vertex_color(_vs, gh, c_black, 0);
draw_primitive_end();
draw_primitive_begin(pr_trianglestrip); // direita
draw_vertex_color(gw - _vs, 0, c_black, 0); draw_vertex_color(_R, 0, c_black, 0.9);
draw_vertex_color(gw - _vs, gh, c_black, 0); draw_vertex_color(_R, gh, c_black, 0.9);
draw_primitive_end();
#endregion

#region FAIXAS DE CINEMA
var _bh = 55 * barras;
draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(_L, -300, _R, _bh, false);
draw_rectangle(_L, gh - _bh, _R, gh + 300, false);
#endregion

#region CAIXA DE TEXTO
var caixa_x = gw / 2;
var caixa_y = gh - 110;

draw_set_color(c_black);
draw_set_alpha(0.6);
draw_roundrect_ext(caixa_x - caixa_w / 2 + 4, caixa_y - caixa_h / 2 + 4, caixa_x + caixa_w / 2 + 4, caixa_y + caixa_h / 2 + 4, 16, 16, false);
draw_set_alpha(0.88);
draw_roundrect_ext(caixa_x - caixa_w / 2, caixa_y - caixa_h / 2, caixa_x + caixa_w / 2, caixa_y + caixa_h / 2, 16, 16, false);

var _cf = cores_falante[cena_atual];
draw_set_color(_cf);
draw_set_alpha(1);
draw_roundrect_ext(caixa_x - caixa_w / 2, caixa_y - caixa_h / 2, caixa_x + caixa_w / 2, caixa_y + caixa_h / 2, 16, 16, true);
#endregion

#region NOME DE QUEM FALA
var _nome = falantes[cena_atual];
var _nw = string_width(_nome) + 30;
var _ex = caixa_x - caixa_w / 2 + 30;
var _ey = caixa_y - caixa_h / 2;
var _tr = (_nome == "???") ? random_range(-1, 1) : 0;

draw_set_color(c_black);
draw_set_alpha(0.95);
draw_roundrect_ext(_ex, _ey - 16, _ex + _nw, _ey + 12, 8, 8, false);
draw_set_color(_cf);
draw_set_alpha(1);
draw_roundrect_ext(_ex, _ey - 16, _ex + _nw, _ey + 12, 8, 8, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_ex + _nw / 2 + _tr, _ey - 2 + _tr, _nome);
#endregion

#region PALAVRAS (com destaque tremendo)
var _nl = array_length(layout);
var _alt_l = 26;
var _y0 = caixa_y - 4 - (_nl - 1) * _alt_l / 2;
var _vis_total = floor(letra_index);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

for (var li = 0; li < _nl; li++) {
    var _l = layout[li];
    var _lx = caixa_x - _l.larg / 2;
    var _ly = _y0 + li * _alt_l;

    for (var _pi = 0; _pi < array_length(_l.palavras); _pi++) {
        var _p = _l.palavras[_pi];
        var _vis = _vis_total - _p.ini + 1;
        if (_vis <= 0) continue;

        var _s = string_copy(_p.txt, 1, min(_vis, string_length(_p.txt)));
        var _dx = _lx + _p.x;
        var _dy = _ly;
        var _cor = make_color_rgb(255, 240, 150);

        if (_p.dest) {
            _dx += random_range(-1.2, 1.2);
            _dy += random_range(-1.2, 1.2);
            _cor = _p.ouro ? make_color_rgb(255, 200, 40) : make_color_rgb(255, 70, 70);
        }

        draw_set_color(c_black);
        draw_text(_dx + 2, _dy + 2, _s);
        draw_set_color(_cor);
        draw_text(_dx, _dy, _s);
    }
}
#endregion

#region SETINHA DE CONTINUAR
if (letra_index >= string_length(textos[cena_atual]) && fade_estado == 0) {
    var _ax = caixa_x + caixa_w / 2 - 30;
    var _ay = caixa_y + caixa_h / 2 - 22 + sin(tempo * 0.15) * 3;
    draw_set_color(make_color_rgb(100, 255, 100));
    draw_triangle(_ax - 8, _ay - 6, _ax + 8, _ay - 6, _ax, _ay + 6, false);
}
#endregion

#region SEGURAR ESC
var _rx = gw - 40;
var _ry = 28;
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(0.5 + segurar_esc * 0.5);
draw_text(_rx - 24, _ry, tr("Segure ESC para pular"));

draw_set_alpha(0.3);
draw_circle(_rx, _ry, 12, true);

if (segurar_esc > 0) {
    draw_set_alpha(1);
    draw_set_color(c_yellow);
    draw_primitive_begin(pr_trianglestrip);
    var _fim = 360 * min(1, segurar_esc);
    for (var a = 0; a <= _fim; a += 10) {
        var _ang = 90 - a;
        draw_vertex(_rx + lengthdir_x(9, _ang), _ry + lengthdir_y(9, _ang));
        draw_vertex(_rx + lengthdir_x(13, _ang), _ry + lengthdir_y(13, _ang));
    }
    draw_primitive_end();
}
#endregion

#region FLASH E FADE
if (flash > 0) {
    draw_set_color(c_white);
    draw_set_alpha(flash);
    draw_rectangle(-300, -300, gw + 300, gh + 300, false);
}
if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(-300, -300, gw + 300, gh + 300, false);
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);