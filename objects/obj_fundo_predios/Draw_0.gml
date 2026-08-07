#region RENDERIZACAO DOS PREDIOS
for (var i = 0; i < qtd_fundo; i++) {
    var p = predios_fundo[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha);
}

for (var i = 0; i < qtd_meio; i++) {
    var p = predios_meio[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha);
}

for (var i = 0; i < qtd_frente; i++) {
    var p = predios_frente[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha);
}
#endregion