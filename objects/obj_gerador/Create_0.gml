#region CONFIGURACAO DO SPAWNER
tempo_spawn_min = 20;
tempo_spawn_max = 50;
timer_spawn = 0;
tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);
#endregion

#region TABELA DE OBJETOS
lista_spawns = [
    {
        objeto: obj_balao,
        y_min: 150,
        y_max: 580,
        alinhado_chao: false,
        chance: 100
    }
];
#endregion