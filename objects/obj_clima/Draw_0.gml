#region FILTRO DE PERIODO (DIA / TARDE / NOITE)
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height() * 2;

switch (global.periodo) {
    case "tarde":
        draw_set_color(make_color_rgb(255, 140, 50));
        draw_set_alpha(0.18);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);
        break;

    case "noite":
        draw_set_color(make_color_rgb(10, 15, 40));
        draw_set_alpha(0.45);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);
        break;
}
#endregion

#region RENDERIZACAO DAS NUVENS
draw_set_color(c_white);
for (var i = 0; i < qtd_nuvens; i++) {
    var n = nuvens[i];
    draw_sprite_ext(spr_nuvem, n.subimg, n.x, n.y, n.escala, n.escala, 0, c_white, n.alpha);
}
#endregion

#region RENDERIZACAO DO CLIMA
switch (global.clima) {
    case "chuva":
        draw_set_color(c_navy);
        draw_set_alpha(0.12);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);

        draw_set_color(c_white);
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            draw_set_alpha(p.alpha);
            var off_x = p.tam * 0.25;
            draw_line_width(p.x, p.y, p.x - off_x, p.y + p.tam, 1.5);
        }
        break;

    case "areia":
        draw_set_color(c_orange);
        draw_set_alpha(0.18);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);

        draw_set_color(c_yellow);
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            draw_set_alpha(p.alpha);
            draw_line_width(p.x, p.y, p.x + p.tam, p.y + (p.tam * 0.1), 1);
        }
        break;

    case "tempestade":
        draw_set_color(c_black);
        draw_set_alpha(0.25);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);

        if (raio_alpha > 0) {
            draw_set_color(c_white);
            draw_set_alpha(raio_alpha);
            draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);
        }

        draw_set_color(c_white);
        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            draw_set_alpha(p.alpha);
            var off_x = p.tam * 0.2;
            draw_line_width(p.x, p.y, p.x - off_x, p.y + p.tam, 1);
        }
        break;

    case "mistico":
        draw_set_color(make_color_rgb(40, 10, 60));
        draw_set_alpha(0.22);
        draw_rectangle(-10, -10, gui_w + 10, gui_h + 10, false);

        for (var i = 0; i < qtd_particulas; i++) {
            var p = particulas[i];
            
            draw_set_color(p.cor);
            draw_set_alpha(p.alpha * 0.3);
            draw_circle(p.x, p.y, p.raio * 2.5, false);
            
            draw_set_color(c_white);
            draw_set_alpha(p.alpha);
            draw_circle(p.x, p.y, p.raio, false);
        }
        break;
}

draw_set_alpha(1.0);
draw_set_color(c_white);
#endregion