#region Desenhar Grid
draw_set_color(c_white);
draw_set_alpha(0.15); 

for (var _i = 0; _i <= colunas_grid; _i++) {
    var _x = _i * global.tamanho_celula;
    draw_line(_x, 0, _x, room_height);
}

for (var _j = 0; _j <= linhas_grid; _j++) {
    var _y = _j * global.tamanho_celula;
    draw_line(0, _y, room_width, _y);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
#endregion