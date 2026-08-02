#region Desenho com Feedback Visual
if (sprite_index != -1) {
    if (pode_construir) {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_lime, 0.6);
    } else {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 0.6);
    }
}
#endregion