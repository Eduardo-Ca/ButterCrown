#region CONFIGURACAO DO SPAWNER
espacamento_min = 90;
espacamento_max = 220;
distancia_acumulada = 0;
proximo_espacamento = irandom_range(espacamento_min, espacamento_max);

max_obstaculos = 20;
margem_spawn_x = 100;
rampa_aparicao = 60;
sem_bonus = 0;
exibir_debug_chances = false;
#endregion

#region TABELA DE OBJETOS
var y_chao = 448;

lista_spawns = [
    { chave: "pessoa",      objeto: obj_pessoa,      categoria: "comum",  chance: 50, dist_min: 0,   alinhado_chao: true,  y_min: y_chao, y_max: y_chao },
    { chave: "balao",       objeto: obj_balao,       categoria: "comum",  chance: 65, dist_min: 0,   alinhado_chao: false, y_min: 150,    y_max: 770 },
    { chave: "bituca",      objeto: obj_bituca,      categoria: "comum",  chance: 15, dist_min: 0,   alinhado_chao: false, y_min: 200,    y_max: 900 },
    { chave: "construcao",  objeto: obj_construcao1, categoria: "comum",  chance: 7,  dist_min: 40,  alinhado_chao: true,  y_min: y_chao, y_max: y_chao },
    { chave: "cachorro",    objeto: obj_cachorro,    categoria: "perigo", chance: 4,  dist_min: 60,  alinhado_chao: true,  y_min: y_chao, y_max: y_chao },
    { chave: "balao_bomba", objeto: obj_balao_bomba, categoria: "perigo", chance: 12, dist_min: 80,  alinhado_chao: false, y_min: 200,    y_max: 740 },
    { chave: "passaro",     objeto: obj_passaro,     categoria: "perigo", chance: 15, dist_min: 150, alinhado_chao: false, y_min: 100,    y_max: 900 }
];

debug_pesos = array_create(array_length(lista_spawns), 0);
debug_total = 0;
#endregion

#region SISTEMA DE BOSSES
intervalo_boss = 1000;
proximo_boss_distancia = 1000;
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
            { objeto: obj_gato_gigante, offset_x: 239, offset_y: 866 }
        ],
        titulo: "PROTEJA O GATO DAS BORBOLETAS DO CAOS",
        subtitulo: "",
        pos_y: 200
    }
];
#endregion