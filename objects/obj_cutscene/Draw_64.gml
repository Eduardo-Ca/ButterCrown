draw_set_font(Font1);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_clear_alpha(c_black, 1.0);

var offset_y = sin(timer_animacao) * 6;

if (sprite_exists(spr_entrada)) {
    var img_x = gui_w / 2;
    var img_y = (gui_h / 2 - 50) + offset_y;

    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_entrada, cena_atual, img_x, img_y, 4.1, 4.1, 0, make_color_rgb(80, 50, 120), 0.25);
    gpu_set_blendmode(bm_normal);

    draw_sprite_ext(spr_entrada, cena_atual, img_x, img_y, 4, 4, 0, c_white, 1);
}

var caixa_x = gui_w / 2;
var caixa_y = gui_h - 110;
var caixa_w = 920;
var caixa_h = 130;

draw_set_color(c_black);
draw_set_alpha(0.6);
draw_roundrect_ext(caixa_x - caixa_w/2 + 4, caixa_y - caixa_h/2 + 4, caixa_x + caixa_w/2 + 4, caixa_y + caixa_h/2 + 4, 16, 16, false);

draw_set_alpha(0.88);
draw_roundrect_ext(caixa_x - caixa_w/2, caixa_y - caixa_h/2, caixa_x + caixa_w/2, caixa_y + caixa_h/2, 16, 16, false);

draw_set_color(make_color_rgb(0, 255, 220));
draw_set_alpha(1.0);
draw_roundrect_ext(caixa_x - caixa_w/2, caixa_y - caixa_h/2, caixa_x + caixa_w/2, caixa_y + caixa_h/2, 16, 16, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_text_ext(caixa_x + 2, caixa_y - 8, texto_exibido, 24, caixa_w - 60);

draw_set_color(make_color_rgb(255, 240, 150));
draw_text_ext(caixa_x, caixa_y - 10, texto_exibido, 24, caixa_w - 60);

if (letra_index >= string_length(textos[cena_atual])) {
    if (floor(current_time / 350) % 2 == 0) {
        draw_set_color(make_color_rgb(100, 255, 100));
        draw_text_transformed(caixa_x + caixa_w/2 - 75, caixa_y + caixa_h/2 - 20, "[ENTER >]", 0.85, 0.85, 0);
    }
}

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);