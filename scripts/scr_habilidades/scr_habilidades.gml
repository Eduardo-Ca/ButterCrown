#region HABILIDADES DA LOJA
function habilidades_definir() {
       global.habilidades = [
        { id: "meteoro", nome: "Meteoro", sprite: spr_meteoro, cor: make_color_rgb(255, 140, 0), nivel_global: "hab_meteoro_nivel" },
		{ id: "dobra", nome: "Dobra", sprite: spr_dobra, cor: make_color_rgb(150, 90, 255), nivel_global: "hab_dobra_nivel" },
		{ id: "sapo", nome: "Sapo Mago", sprite: spr_sapo_mago, cor: make_color_rgb(190, 90, 255), nivel_global: "hab_sapo_nivel" },
		{ id: "tornado", nome: "Fúria dos Ventos", sprite: spr_vento, cor: make_color_rgb(120, 220, 255), nivel_global: "hab_tornado_nivel" }
    ];
    global.hab_slots = [];
    global.hab_cargas = array_create(array_length(global.habilidades), 0);
}

function habilidades_atualizar_slots() {
    for (var i = 0; i < array_length(global.habilidades); i++) {
        var _tem = (variable_global_get(global.habilidades[i].nivel_global) > 0);

        var _pos = -1;
        for (var s = 0; s < array_length(global.hab_slots); s++) {
            if (global.hab_slots[s] == i) {
                _pos = s;
                break;
            }
        }

        if (_tem && _pos == -1) array_push(global.hab_slots, i);
        if (!_tem && _pos != -1) array_delete(global.hab_slots, _pos, 1);
    }
}

function habilidades_iniciar_partida() {
    for (var i = 0; i < array_length(global.habilidades); i++) {
        global.hab_cargas[i] = variable_global_get(global.habilidades[i].nivel_global);
    }
}

function ativar_habilidade(_id) {
    switch (_id) {
        case "meteoro":
            if (!instance_exists(obj_borboleta)) return false;
            if (obj_borboleta.modo_meteoro || obj_borboleta.modo_foguete) return false;
            iniciar_meteoro();
            return obj_borboleta.modo_meteoro;
		case "dobra":
            if (!instance_exists(obj_borboleta)) return false;
            if (obj_borboleta.modo_meteoro || obj_borboleta.modo_foguete || obj_borboleta.modo_dobra) return false;
            iniciar_dobra();
            return obj_borboleta.modo_dobra;
		case "sapo":
            return invocar_sapo();
		case "tornado": return iniciar_tornados();
    }
    return false;
}

function usar_habilidade(_slot) {
    var _i = global.hab_slots[_slot];

    if (global.hab_cargas[_i] <= 0) {
        tocar_som(snd_sem_energia);
        return;
    }

    if (ativar_habilidade(global.habilidades[_i].id)) {
        global.hab_cargas[_i]--;
    }
}

function habilidade_ativa(_id) {
    switch (_id) {
        case "meteoro": return instance_exists(obj_borboleta) && obj_borboleta.modo_meteoro;
		case "dobra": return instance_exists(obj_borboleta) && obj_borboleta.modo_dobra;
		case "sapo": return instance_exists(obj_sapo_mago);
		case "tornado": return instance_exists(obj_borboleta) && obj_borboleta.modo_tornado;
		
    }
    return false;
}
#endregion