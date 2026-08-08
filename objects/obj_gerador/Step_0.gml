if (global.pausado) exit;

#region SPAWN DE BOSS
if (global.distancia_percorrida >= proximo_boss_distancia) {
    proximo_boss_distancia += intervalo_boss;
    
    var _boss_dados = lista_bosses[index_boss_atual % array_length(lista_bosses)];
    index_boss_atual += 1;
    
    var _alerta = instance_create_depth(0, 0, -9999, obj_alerta_boss);
    with (_alerta) {
        texto_titulo = _boss_dados.titulo;
        texto_subtitulo = _boss_dados.subtitulo;
    }
    
    var _cam_x = camera_get_view_x(view_camera[0]);
    var _cam_w = camera_get_view_width(view_camera[0]);
    if (_cam_w == 0) _cam_w = room_width;
    
    instance_create_layer(_cam_x + _cam_w + 100, _boss_dados.pos_y, "Instances", _boss_dados.objeto);
}
#endregion

#region SPAWN 
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
        
        if (item_sorteado != undefined) {
            var pos_y = 0;
            
            if (item_sorteado.alinhado_chao) {
                if (instance_exists(obj_chao)) {
                    var metade_altura = sprite_get_height(object_get_sprite(item_sorteado.objeto)) / 2;
                    pos_y = obj_chao.bbox_top - metade_altura + 3;
                } else {
                    pos_y = 448;
                }
            } else {
                pos_y = irandom_range(item_sorteado.y_min, item_sorteado.y_max);
            }
            
            instance_create_depth(x, pos_y, depth, item_sorteado.objeto);
        }
    }
}
#endregion