#region CONFIGURACOES DA LOJA E ESTADOS

upgrades = [
    { nome: "Energia Maxima", nivel_global: "upg_energia_nivel", max_lvl: 5, preco_base: 15, esc: 45 },
    { nome: "Forca do Impulso", nivel_global: "upg_impulso_nivel", max_lvl: 5, preco_base: 15, esc: 35 },
    { nome: "Qtd. de Quiques", nivel_global: "upg_quiques_nivel", max_lvl: 3, preco_base: 30, esc: 25 },
    { nome: "Boost Velocidade", nivel_global: "upg_boost_nivel", max_lvl: 5, preco_base: 20, esc: 30 }
];

total_upgrades = array_length(upgrades);
hover_item = -1;

timer_loja = 0;
painel_escala = 0;
#endregion