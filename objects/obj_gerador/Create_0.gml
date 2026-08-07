#region CONFIGURACAO DO SPAWNER
tempo_spawn_min = 10;
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
	    chance: 50
	},
	{
	    objeto: obj_balao_bomba,
	    y_min: 400,  
	    y_max: 700,  
	    alinhado_chao: false,
	    chance: 20
	},
	{
        objeto: obj_pessoa,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 50
    },
	{
        objeto: obj_cachorro,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 12
    },
	{
	    objeto: obj_bituca,
	    y_min: 300,  
	    y_max: 800,  
	    alinhado_chao: false,
	    chance: 15
	},
];
#endregion