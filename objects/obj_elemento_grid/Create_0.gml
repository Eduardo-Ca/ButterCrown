#region Configuracao Inicial
x = floor(x / global.tamanho_celula) * global.tamanho_celula;
y = floor(y / global.tamanho_celula) * global.tamanho_celula;

if (instance_exists(obj_grid)) {
    obj_grid.definir_valor_grid(x, y, id);
}
#endregion