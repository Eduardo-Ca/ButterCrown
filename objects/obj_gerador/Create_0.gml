#region CONFIGURACAO DO SPAWNER
tempo_spawn_min = 15;
tempo_spawn_max = 60;
timer_spawn = 0;
tempo_atual = irandom_range(tempo_spawn_min, tempo_spawn_max);

var y_chao = 448;    
var y_meio = 162;     
var y_topo = 40;          
#endregion

#region TABELA DE OBJETOS COMUNS
lista_spawns = [
    {
        objeto: obj_balao,
        y_min: 80,  
        y_max: 280,  
        alinhado_chao: false,
        chance: 35
    },
    {
        objeto: obj_balao_bomba,
        y_min: 80,  
        y_max: 280,  
        alinhado_chao: false,
        chance: 15
    },
    {
        objeto: obj_pessoa,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 30
    },
    {
        objeto: obj_construcao1,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 8
    },
    {
        objeto: obj_cachorro,
        y_min: y_chao,
        y_max: y_chao,
        alinhado_chao: true,
        chance: 10
    },
    {
        objeto: obj_bituca,
        y_min: 100,  
        y_max: 320,  
        alinhado_chao: false,
        chance: 20
    },
    {
        objeto: obj_passaro,
        y_min: 60,  
        y_max: 220,  
        alinhado_chao: false,
        chance: 18
    }
];
#endregion

#region SISTEMA DE BOSSES
intervalo_boss = 100;
proximo_boss_distancia = 100;
index_boss_atual = 0;

lista_bosses = [
    {
        objeto: obj_peixe_azul,
        titulo: "REIS ABISSAIS",
        subtitulo: "A AMEAÇA DOS MARES",
        pos_y: 200
    }

];
#endregion