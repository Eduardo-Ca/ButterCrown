#region DESENHO DA DOBRA
if (fade <= 0.01 && flash <= 0) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

#region CENTRO (SEGUE A BORBOLETA)
var _px = _gw * 0.3;
var _py = _gh * 0.5;

if (instance_exists(obj_borboleta)) {
    var _cam = view_camera[0];
    _px = clamp((obj_borboleta.x - camera_get_view_x(_cam)) * _gw / camera_get_view_width(_cam), 0, _gw);
    _py = clamp((obj_borboleta.y - camera_get_view_y(_cam)) * _gh / camera_get_view_height(_cam), 0, _gh);
}
#endregion

var _maxr = point_distance(0, 0, _gw, _gh) * 1.1;

if (fade > 0.01) {

    #region TELA ONDULADA E RGB SEPARADO (SEM SHADER)
    if (surface_exists(application_surface)) {
        var _sw = surface_get_width(application_surface);
        var _sh = surface_get_height(application_surface);
        var _xs = _gw / _sw;
        var _ys = _gh / _sh;

        // Ondulacao: redesenha a tela em faixas deslocadas por um seno
        var _faixas = 32;
        var _hs = _sh / _faixas;
        for (var j = 0; j < _faixas; j++) {
            var _off = sin(tempo * 0.15 + j * 0.5) * 14 * fade;
            draw_surface_part_ext(application_surface, 0, j * _hs, _sw, _hs + 1, _off, j * _hs * _ys, _xs, _ys, c_white, 0.55 * fade);
        }

        // Separacao de cores: copias coloridas deslocadas
        gpu_set_blendmode(bm_add);
        var _d = (6 + 4 * sin(tempo * 0.1)) * fade;
        draw_surface_ext(application_surface,  _d, 0, _xs, _ys, 0, c_red,  0.22 * fade);
        draw_surface_ext(application_surface, -_d, 0, _xs, _ys, 0, c_aqua, 0.22 * fade);
        gpu_set_blendmode(bm_normal);
    }
    #endregion

    #region BANHO DE COR
    draw_set_alpha(0.22 * fade);
    draw_rectangle_color(0, 0, _gw, _gh,
        make_color_hsv(hue, 255, 255),
        make_color_hsv((hue + 64) mod 256, 255, 255),
        make_color_hsv((hue + 128) mod 256, 255, 255),
        make_color_hsv((hue + 192) mod 256, 255, 255),
        false);
    #endregion

    gpu_set_blendmode(bm_add);

    #region ANEIS ONDULADOS DO TUNEL
    var _n = 10;
    var _passo_ang = 10;

    for (var i = _n; i >= 0; i--) {
        var _k = i + anel_fase;
        var _f = _k / _n;
        var _raio = _f * _f * _maxr;
        var _esp = 2 + _f * 18;
        var _c = make_color_hsv((hue + _k * 18) mod 256, 255, 255);
        var _a = 0.25 * fade * (1 - _f * 0.5);

        draw_primitive_begin(pr_trianglestrip);
        for (var _ang = 0; _ang <= 360; _ang += _passo_ang) {
            var _onda = 1 + 0.08 * sin(degtorad(_ang) * 6 + tempo * 0.1 + i);
            var _r1 = max(0, (_raio - _esp) * _onda);
            var _r2 = (_raio + _esp) * _onda;
            draw_vertex_color(_px + lengthdir_x(_r1, _ang), _py + lengthdir_y(_r1, _ang), _c, _a);
            draw_vertex_color(_px + lengthdir_x(_r2, _ang), _py + lengthdir_y(_r2, _ang), _c, _a);
        }
        draw_primitive_end();
    }
    #endregion

    #region RAIOS
    draw_set_alpha(0.12 * fade);

    var _raios = 16;
    var _passo = 360 / _raios;
    for (var i = 0; i < _raios; i++) {
        var _a1 = rotacao + i * _passo;
        var _a2 = _a1 + _passo * 0.5;
        var _cr = make_color_hsv((hue + i * 16) mod 256, 255, 255);

        draw_triangle_color(
            _px, _py,
            _px + lengthdir_x(_maxr, _a1), _py + lengthdir_y(_maxr, _a1),
            _px + lengthdir_x(_maxr, _a2), _py + lengthdir_y(_maxr, _a2),
            c_white, _cr, _cr, false
        );
    }
    #endregion

    #region RISCOS DE LUZ
    draw_set_alpha(0.8 * fade);

    for (var i = 0; i < qtd_riscos; i++) {
        var _r = riscos[i];
        var _x1 = _r.nx * _gw;
        var _y1 = _r.ny * _gh;

        draw_set_color(make_color_hsv((hue + _r.cor_off) mod 256, 200, 255));
        draw_line_width(_x1, _y1, _x1 + _r.comp * _gw, _y1, _r.larg * 2);
    }
    #endregion

    gpu_set_blendmode(bm_normal);
}

#region FLASH
if (flash > 0) {
    draw_set_color(c_white);
    draw_set_alpha(flash * 0.8);
    draw_rectangle(0, 0, _gw, _gh, false);
}
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
#endregion