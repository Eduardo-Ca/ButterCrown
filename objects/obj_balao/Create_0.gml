#region CONFIGURACOES E PROPRIEDADES
event_inherited();

boost_velocidade = 0.5;
pontos_caos = 1;
assustado = false;

tempo_balanco = random(100);
vel_balanco = 0.03;
angulo_maximo = 15;

fase_fuga = 0;
timer_fuga = 0;
direcao_fuga_x = 1;
vel_fuga_x = 0;
vel_fuga_y = 0;
tempo_vida_fuga = 180;

escala_x = 1;
escala_y = 1;
angulo_offset = 0;
vel_angulo = 0;
mola_forca = 0.25;
mola_amortecimento = 0.82;


linhas_vento = [];
for (var i = 0; i < 4; i++) {
    array_push(linhas_vento, {
        off_x: random_range(-10, 10),
        off_y: random_range(-15, 15),
        alpha: 1
    });
}
#endregion