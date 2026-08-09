var _escala_x = image_xscale * escala_dano * escala_morte;
var _escala_y = image_yscale * escala_dano * escala_morte;
var _alpha = image_alpha * alpha_morte;


if (tempo_flash_dano > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, _escala_x, _escala_y, image_angle, image_blend, _alpha);
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_sprite_ext(sprite_index, image_index, x, y, _escala_x, _escala_y, image_angle, image_blend, _alpha);
}