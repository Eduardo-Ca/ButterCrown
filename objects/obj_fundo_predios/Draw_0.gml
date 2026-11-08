#region RENDERIZACAO DOS PREDIOS
var _af = instance_exists(obj_fases) ? (1 - obj_fases.alpha_praia) : 1;
if (_af <= 0.01) exit;

for (var i = 0; i < qtd_fundo; i++) {
    var p = predios_fundo[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha * _af);
}

for (var i = 0; i < qtd_meio; i++) {
    var p = predios_meio[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha * _af);
}

for (var i = 0; i < qtd_frente; i++) {
    var p = predios_frente[i];
    draw_sprite_ext(spr_predios, p.subimg, p.x, p.y, p.escala_x, p.escala_y, 0, c_white, p.alpha * _af);
}
#endregion