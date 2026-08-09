if (global.pausado) exit;

#region CHECAGEM E SPAWN DO BOSS
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
    
    var _spawn_x = _cam_x + _cam_w + 100;
    
    var _lista_objs = _boss_dados.objetos;
    for (var j = 0; j < array_length(_lista_objs); j++) {
        var _obj_info = _lista_objs[j];
        var _off_x = variable_struct_exists(_obj_info, "offset_x") ? _obj_info.offset_x : 0;
        var _off_y = variable_struct_exists(_obj_info, "offset_y") ? _obj_info.offset_y : 0;
        
        instance_create_layer(_spawn_x + _off_x, _boss_dados.pos_y + _off_y, "Instances", _obj_info.objeto);
    }
}
#endregion

#region TEMPO E SPAWN NORMAL

if (global.vel_mundo > 0.5 && !instance_exists(obj_boss)) {
    timer_spawn += 1;
    
    if (timer_spawn >= tempo_atual) {
        timer_spawn = 0;
        tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);
        
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
                    var _spr = object_get_sprite(item_sorteado.objeto);
                    var metade_altura = (_spr != -1) ? (sprite_get_height(_spr) / 2) : 16;
                    
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