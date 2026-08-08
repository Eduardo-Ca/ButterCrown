#region CONFIGURAÇÕES DA LOJA
upgrades = [
    { nome: "Energia Máxima",        nivel_global: "upg_energia_nivel",     max_lvl: 10, preco_base: 15, esc: 40 },
    { nome: "Força do Impulso",      nivel_global: "upg_impulso_nivel",     max_lvl: 4,  preco_base: 15, esc: 33 },
    { nome: "Qtd. de Quiques",        nivel_global: "upg_quiques_nivel",     max_lvl: 5,  preco_base: 30, esc: 23 },
    { nome: "Boost Velocidade",      nivel_global: "upg_boost_nivel",       max_lvl: 3,  preco_base: 20, esc: 27 },
    { nome: "Limite de Velocidade",  nivel_global: "upg_limite_vel_nivel",  max_lvl: 6,  preco_base: 15, esc: 27 },
    { nome: "Impulso Inicial",       nivel_global: "upg_vel_inicial_nivel", max_lvl: 3,  preco_base: 25, esc: 33 }  
];

total_upgrades = array_length(upgrades);
hover_item = -1;

timer_loja = 0;
painel_escala = 0;
#endregion