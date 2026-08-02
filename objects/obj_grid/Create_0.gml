#region Propriedades da Grid
colunas_grid = floor(room_width / global.tamanho_celula);
linhas_grid = floor(room_height / global.tamanho_celula);

grid_mapa = array_create(colunas_grid);

for (var _i = 0; _i < colunas_grid; _i++) {
    grid_mapa[_i] = array_create(linhas_grid, noone);
}
#endregion

#region Funcoes de Conversao e Alinhamento
function obter_grid_x(_pos_x) {
    return floor(_pos_x / global.tamanho_celula);
}

function obter_grid_y(_pos_y) {
    return floor(_pos_y / global.tamanho_celula);
}

function alinhar_grid_x(_pos_x) {
    return floor(_pos_x / global.tamanho_celula) * global.tamanho_celula;
}

function alinhar_grid_y(_pos_y) {
    return floor(_pos_y / global.tamanho_celula) * global.tamanho_celula;
}
#endregion

#region Funcoes de Leitura e Escrita
function obter_valor_grid(_pos_x, _pos_y) {
    var _gx = obter_grid_x(_pos_x);
    var _gy = obter_grid_y(_pos_y);
    
    if (_gx >= 0 && _gx < colunas_grid && _gy >= 0 && _gy < linhas_grid) {
        return grid_mapa[_gx][_gy];
    }
    return -1;
}

function definir_valor_grid(_pos_x, _pos_y, _valor) {
    var _gx = obter_grid_x(_pos_x);
    var _gy = obter_grid_y(_pos_y);
    
    if (_gx >= 0 && _gx < colunas_grid && _gy >= 0 && _gy < linhas_grid) {
        grid_mapa[_gx][_gy] = _valor;
    }
}

function celula_ocupada(_pos_x, _pos_y) {
    var _valor = obter_valor_grid(_pos_x, _pos_y);
    return (_valor != noone && _valor != -1);
}
#endregion

#region Funcoes de Criacao e Destruicao
function colocar_objeto_na_celula(_pos_x, _pos_y, _objeto, _camada = "Instances") {
    if (!celula_ocupada(_pos_x, _pos_y)) {
        var _x_alinhado = alinhar_grid_x(_pos_x);
        var _y_alinhado = alinhar_grid_y(_pos_y);
        
        var _instancia = instance_create_layer(_x_alinhado, _y_alinhado, _camada, _objeto);
        definir_valor_grid(_x_alinhado, _y_alinhado, _instancia);
        return _instancia;
    }
    return noone;
}

function destruir_objeto_da_celula(_pos_x, _pos_y) {
    var _instancia = obter_valor_grid(_pos_x, _pos_y);
    
    if (_instancia != noone && _instancia != -1 && instance_exists(_instancia)) {
        instance_destroy(_instancia);
        limpar_celula(_pos_x, _pos_y);
        return true;
    }
    return false;
}

function limpar_celula(_pos_x, _pos_y) {
    definir_valor_grid(_pos_x, _pos_y, noone);
}
#endregion