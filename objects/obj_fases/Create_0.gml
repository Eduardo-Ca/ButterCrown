#region LISTA DE FASES (adicione mais aqui depois)
fases = [
    { id: "praia",  nome: "PRAIA",  distancia: 1020, cor: make_color_rgb(255, 220, 120) },
    { id: "cidade", nome: "CIDADE", distancia: 1020, cor: make_color_rgb(150, 200, 255) }
];
#endregion

#region PROFUNDIDADE (atras dos predios)
if (layer_exists("fundo")) depth = layer_get_depth("fundo") + 10;
#endregion

#region CONFIGURACAO DO MAR
altura_mar = 140;     // distancia do chao ate o horizonte
areia_altura = 22;    // faixa de areia
qtd_ondas = 7;

mar_cor_longe = make_color_rgb(120, 200, 235);
mar_cor_perto = make_color_rgb(30, 110, 180);
areia_seca = make_color_rgb(240, 215, 160);
areia_molhada = make_color_rgb(200, 170, 120);

tempo = 0;
mar_offset = 0;

qtd_brilhos = 35;
brilhos = array_create(qtd_brilhos);
for (var i = 0; i < qtd_brilhos; i++) {
    brilhos[i] = { x: random(1), y: random(1), fase: random(pi * 2), vel: random_range(0.05, 0.12) };
}

qtd_pontos = 40;
pontos_areia = array_create(qtd_pontos);
for (var i = 0; i < qtd_pontos; i++) {
    pontos_areia[i] = { x: random(1), y: random(1) };
}
#endregion

#region COQUEIROS
spr_coq = asset_get_index("spr_coqueiro"); // -1 se ainda nao existir
qtd_coqueiros = 5;
coqueiros = array_create(qtd_coqueiros);
for (var i = 0; i < qtd_coqueiros; i++) {
    coqueiros[i] = {
        x: random(900),
        esc: random_range(0.9, 1.3),
        flip: choose(-1, 1),
        fase: random(10)
    };
}
#endregion

#region INICIAR / REINICIAR
reiniciar_fases = function() {
    fase_index = 0;
    numero_fase = 1;
    global.fase = fases[0].id;
    proxima_troca = fases[0].distancia;
    alpha_praia = (global.fase == "praia") ? 1 : 0;
    banner_max = 180;
    banner_timer = banner_max;
    banner_titulo = "FASE 1";
    banner_nome = fases[0].nome;
    banner_cor = fases[0].cor;
    ultima_dist = 0;
};
reiniciar_fases();
#endregion