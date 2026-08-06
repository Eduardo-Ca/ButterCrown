#region DESENHO BASE
draw_sprite_ext(
    sprite_index, 
    image_index, 
    x, 
    y, 
    image_xscale, 
    image_yscale, 
    image_angle, 
    image_blend, 
    image_alpha
);
#endregion

#region DESENHO DAS ROUPAS
if (corpo_index != -1) {
    draw_sprite_ext(
        spr_corpo, 
        corpo_index, 
        x, 
        y, 
        image_xscale, 
        image_yscale, 
        image_angle, 
        image_blend, 
        image_alpha
    );
}

if (cabeca_index != -1) {
    draw_sprite_ext(
        spr_cabeca, 
        cabeca_index, 
        x, 
        y, 
        image_xscale, 
        image_yscale, 
        image_angle, 
        image_blend, 
        image_alpha
    );
}
#endregion