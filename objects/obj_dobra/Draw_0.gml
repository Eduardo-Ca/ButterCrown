#region DESENHO DA DOBRA
if (fade <= 0.01 && flash <= 0) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _px = _gw * 0.7;
var _py = _gh * 0.5;

if (instance_exists(obj_borboleta)) {
    var _vy = camera_get_view_y(view_camera[0]);
    var _vh = camera_get_view_height(view_camera[0]);
    _py = clamp((obj_borboleta.y - _vy) * _gh / _vh, 0, _gh);
}

var _maxr = point_distance(0, 0, _gw, _gh) * 1.1;

if (fade > 0.01) {

    #region BASE ESCURA
    draw_set_color(make_color_hsv((hue + 128) mod 256, 255, 90));
    draw_set_alpha(0.4 * fade);
    draw_rectangle(0, 0, _gw, _gh, false);
    #endregion

    #region ANEIS DO TUNEL
    draw_set_circle_precision(48);
    draw_set_alpha(0.5 * fade);

    var _n = 14;
    for (var i = _n; i >= 0; i--) {
        var _k = i + anel_fase;
        var _f = _k / _n;
        draw_set_color(make_color_hsv((hue + _k * 18) mod 256, 255, 170 + 85 * sin(_k * pi)));
        draw_circle(_px, _py, _f * _f * _maxr, false);
    }

    draw_set_circle_precision(24);
    #endregion

    gpu_set_blendmode(bm_add);

    #region RAIOS
    draw_set_alpha(0.35 * fade);

    var _raios = 16;
    var _passo = 360 / _raios;
    for (var i = 0; i < _raios; i++) {
        var _a1 = rotacao + i * _passo;
        var _a2 = _a1 + _passo * 0.5;
        var _c = make_color_hsv((hue + i * 16) mod 256, 255, 255);

        draw_triangle_color(
            _px, _py,
            _px + lengthdir_x(_maxr, _a1), _py + lengthdir_y(_maxr, _a1),
            _px + lengthdir_x(_maxr, _a2), _py + lengthdir_y(_maxr, _a2),
            c_white, _c, _c, false
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
draw_set_color(c_white);
draw_set_alpha(flash * 0.8);
draw_rectangle(0, 0, _gw, _gh, false);
#endregion

draw_set_alpha(1);
draw_set_color(c_white);
#endregion