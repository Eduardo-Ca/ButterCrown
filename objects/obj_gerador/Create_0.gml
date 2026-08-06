#region CONFIGURACAO DO SPAWNER
tempo_spawn_min = 20;
tempo_spawn_max = 50;
timer_spawn = 0;
tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);

var y_chao = 448;    
var y_meio = 162;      
var y_topo = 40;          
#endregion

#region TABELA DE OBJETOS
lista_spawns = [
	{
	    objeto: obj_balao,
	    y_min: 400,  
	    y_max: 700,  
	    alinhado_chao: false,
	    chance: 100
	}
];
#endregion