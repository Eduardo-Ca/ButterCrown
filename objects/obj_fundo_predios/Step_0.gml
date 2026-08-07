#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion

#region MOVIMENTACAO E REICICLAGEM DAS CAMADAS
var larg_tela = room_width;

if (view_enabled) {
    larg_tela = camera_get_view_width(view_camera[0]);
}

var base_y = room_height;
if (instance_exists(obj_chao)) {
    base_y = obj_chao.y;
}

var vel_fator = global.vel_mundo;

for (var i = 0; i < qtd_fundo; i++) {
    var p = predios_fundo[i];
    p.x -= p.vel * vel_fator;
    
    if (p.x < -300) {
        p.x = larg_tela + random_range(100, 400);
        p.y = base_y;
        p.subimg = irandom_range(7, 10);
    }
}

for (var i = 0; i < qtd_meio; i++) {
    var p = predios_meio[i];
    p.x -= p.vel * vel_fator;
    
    if (p.x < -350) {
        p.x = larg_tela + random_range(100, 400);
        p.y = base_y;
        p.subimg = irandom_range(4, 6);
    }
}

for (var i = 0; i < qtd_frente; i++) {
    var p = predios_frente[i];
    p.x -= p.vel * vel_fator;
    
    if (p.x < -400) {
        p.x = larg_tela + random_range(100, 400);
        p.y = base_y;
        p.subimg = irandom_range(0, 3);
    }
}
#endregion