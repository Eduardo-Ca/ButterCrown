#region TEMPO E SPAWN
if (global.vel_mundo > 0.5) {
    timer_spawn += 1;
    
    if (timer_spawn >= tempo_atual) {
        timer_spawn = 0;
        tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);
        
        var total_peso = 0;
        for (var i = 0; i < array_length(lista_spawns); i++) {
            total_peso += lista_spawns[i].chance;
        }
        
        var sorteio = irandom_range(1, total_peso);
        var acumulado = 0;
        var item_sorteado = undefined;
        
        for (var i = 0; i < array_length(lista_spawns); i++) {
            acumulado += lista_spawns[i].chance;
            if (sorteio <= acumulado) {
                item_sorteado = lista_spawns[i];
                break;
            }
        }
        
        var pos_y = 0;
        
        if (item_sorteado.alinhado_chao) {
            if (instance_exists(obj_chao)) {
                // Pega a altura da sprite do objeto para compensar a origem no meio
                var metade_altura = sprite_get_height(object_get_sprite(item_sorteado.objeto)) / 2;
                pos_y = obj_chao.bbox_top - metade_altura;
            }
        } else {
            pos_y = irandom_range(item_sorteado.y_min, item_sorteado.y_max);
        }
        
        instance_create_layer(x, pos_y, "Instances", item_sorteado.objeto);
    }
}
#endregion