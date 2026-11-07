#region CONFIGURAÇÕES DA LOJA
abas = [
    {
        nome: "MOVIMENTO",
        cor: make_color_rgb(70, 200, 255),
        upgrades: [
            { nome: "Energia Máxima", desc: "Mais batidas de asa por voo", nivel_global: "upg_energia_nivel", max_lvl: 10, preco_base: 15, esc: 40,
              valor: function(_n) { return string(global.energia_max_base + _n * global.energia_max_por_nivel); } },
            { nome: "Limite de Velocidade", desc: "Velocidade máxima do mundo", nivel_global: "upg_limite_vel_nivel", max_lvl: 6, preco_base: 15, esc: 27,
              valor: function(_n) { return string((global.velocidade_maxima_base + _n * global.vel_max_por_nivel) * 10) + " km/h"; } },
            { nome: "Qtd. de Quiques", desc: "Quiques no chão antes de cair", nivel_global: "upg_quiques_nivel", max_lvl: 6, preco_base: 30, esc: 25,
              valor: function(_n) { return string(global.quiques_max_base + _n * global.quiques_max_por_nivel); } },
            { nome: "Boost Velocidade", desc: "Velocidade ganha a cada impulso", nivel_global: "upg_boost_nivel", max_lvl: 4, preco_base: 20, esc: 27,
              valor: function(_n) { return string_format(global.boost_base + _n * global.boost_por_nivel, 1, 1); } },
            { nome: "Força do Impulso", desc: "Altura de cada batida de asa", nivel_global: "upg_impulso_nivel", max_lvl: 4, preco_base: 15, esc: 33,
              valor: function(_n) { return string_format(abs(global.impulso_base + _n * global.impulso_por_nivel), 1, 1); } },
            { nome: "Impulso Inicial", desc: "Velocidade ao começar o voo", nivel_global: "upg_vel_inicial_nivel", max_lvl: 4, preco_base: 25, esc: 33,
              valor: function(_n) { return string((global.vel_inicial_base + _n * global.vel_inicial_por_nivel) * 10) + " km/h"; } }
        ]
    },
    {
        nome: "SORTE",
        cor: make_color_rgb(100, 225, 130),
        upgrades: [
            { nome: "Mais Balões", desc: "Balões aparecem com mais frequência", nivel_global: "upg_balao_nivel", max_lvl: 3, preco_base: 20, esc: 30,
              valor: function(_n) { return "+" + string(round((mult_balao(_n) - 1) * 100)) + "%"; } },
            { nome: "Mais Pessoas", desc: "Mais pessoas para quicar no chão", nivel_global: "upg_pessoa_nivel", max_lvl: 3, preco_base: 20, esc: 30,
              valor: function(_n) { return "+" + string(round((mult_pessoa(_n) - 1) * 100)) + "%"; } },
            { nome: "Mais Lojas de Fogos", desc: "Lojas de fogos dão grande impulso", nivel_global: "upg_predio_nivel", max_lvl: 3, preco_base: 25, esc: 35,
              valor: function(_n) { return "+" + string(round((mult_fogos(_n) - 1) * 100)) + "%"; } },
            { nome: "Perigos Raros", desc: "Menos bombas, pássaros e cachorros", nivel_global: "upg_perigo_nivel", max_lvl: 3, preco_base: 30, esc: 40,
              valor: function(_n) { return "-" + string(round((1 - mult_perigo(_n)) * 100)) + "%"; } }
        ]
    },
	{
	    nome: "HABILIDADES",
	    cor: make_color_rgb(190, 120, 255),
	    upgrades: [
		    { nome: "Meteoro", desc: "Mergulha e destrói tudo", nivel_global: "hab_meteoro_nivel", max_lvl: 5, preco_base: 60, esc: 80,
		      valor: function(_n) { return string(_n) + ((_n == 1) ? " uso" : " usos"); } },
			{ nome: "Dobra", desc: "Dash dimensional que esmaga tudo", nivel_global: "hab_dobra_nivel", max_lvl: 5, preco_base: 80, esc: 100,
			  valor: function(_n) { return string(_n) + ((_n == 1) ? " uso" : " usos"); } },
			{ nome: "Sapo Mago", desc: "Invoca um amigo que cria nuvens", nivel_global: "hab_sapo_nivel", max_lvl: 5, preco_base: 100, esc: 120,
			  valor: function(_n) { return string(_n) + ((_n == 1) ? " uso" : " usos"); } }
			  
		]
	}
];
#endregion

#region ESTADO
rolagem = 0;
flash_row = array_create(32, 0);
shake_row = array_create(32, 0);
aba_atual = 0;
aba_alpha = 1;
hover_aba = -1;
hover_item = -1;
hover_botao = -1;
hover_jogar = false;

timer_loja = 0;
painel_escala = 0;
caos_exibido = global.caos;
flash_caos = 0;
flash_row = array_create(8, 0);
shake_row = array_create(8, 0);
#endregion

#region LAYOUT
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

px = _gw / 2;
py = _gh / 2;
max_visiveis = 6;
painel_w = 940;
painel_h = 620;
painel_x1 = px - painel_w / 2;
painel_y1 = py - painel_h / 2;
painel_x2 = px + painel_w / 2;
painel_y2 = py + painel_h / 2;

margem = 30;
tab_y1 = painel_y1 + 72;
tab_h = 40;
tab_gap = 10;

linhas_y1 = painel_y1 + 132;
linha_h = 62;
linha_gap = 8;
linha_x1 = painel_x1 + margem;
linha_x2 = painel_x2 - margem;

jogar_x1 = px - 150;
jogar_x2 = px + 150;
jogar_y1 = painel_y2 - 64;
jogar_y2 = painel_y2 - 20;
#endregion

#region ESTRELAS DE FUNDO
estrelas_bg = array_create(50);
for (var i = 0; i < 50; i++) {
    estrelas_bg[i] = {
        x: random(_gw),
        y: random(_gh),
        v: random_range(0.3, 1.5),
        tam: choose(1, 2, 2, 3),
        alpha: random_range(0.2, 0.7)
    };
}
#endregion