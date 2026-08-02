#region validação
x = obj_grid.alinhar_grid_x(mouse_x);
y = obj_grid.alinhar_grid_y(mouse_y);

if (instance_exists(obj_grid)) {
    pode_construir = !obj_grid.celula_ocupada(x, y);
}

if (mouse_check_button_pressed(mb_left) && pode_construir && objeto_para_construir != noone) {
    obj_grid.colocar_objeto_na_celula(x, y, objeto_para_construir);
}

if (mouse_check_button_pressed(mb_right)) {
    instance_destroy();
}
#endregion