#region CONFIGURACAO DO SPAWNER
tempo_spawn_min = 8;
tempo_spawn_max = 30;
timer_spawn = 0;
tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);

var y_chao = 448;    
var y_meio = 162;     
var y_topo = 40;          
#endregion

#region TABELA DE OBJETOS COMUNS
lista_spawns = [
    {
        objeto: obj_pessoa,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 70
    },
    {
        objeto: obj_balao,
        y_min: 200,  
        y_max: 740,  
        alinhado_chao: false,
        chance: 60
    },
    {
        objeto: obj_balao_bomba,
        y_min: 200,  
        y_max: 740,  
        alinhado_chao: false,
        chance: 12
    },
    {
        objeto: obj_cachorro,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 6
    },
    {
        objeto: obj_construcao1,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 10
    },
    {
        objeto: obj_bituca,
        y_min: 200,  
        y_max: 900,  
        alinhado_chao: false,
        chance: 15
    },
    {
        objeto: obj_passaro,
        y_min: 100,  
        y_max: 900,  
        alinhado_chao: false,
        chance: 15
    }
];

total_peso = 0;
for (var i = 0; i < array_length(lista_spawns); i++) {
    total_peso += lista_spawns[i].chance;
}

exibir_debug_chances = false;
#endregion

#region SISTEMA DE BOSSES
intervalo_boss = 100;
proximo_boss_distancia = 100;
index_boss_atual = 0;

lista_bosses = [
    {
        objetos: [
		    { objeto: obj_peixe_vermelho, offset_x: 30, offset_y: -50 },
            { objeto: obj_peixe_azul, offset_x: 0, offset_y: 0 }
    
        ],
        titulo: "REIS ABISSAIS",
        subtitulo: "A AMEAÇA DOS MARES",
        pos_y: 200
    },
	{
	    objetos: [
			{ objeto: obj_gato_gigante, offset_x: 239, offset_y: 866 },
    
	    ],
	    titulo: "PROTEJA O GATO DAS",
	    subtitulo: "BORBOLETAS DO CAOS",
	    pos_y: 200
	}
];
#endregion