#region 
if (sprite_index != -1) {
    var _cor = pode_construir ? c_lime : c_red;
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _cor, 0.5);
}
#endregion