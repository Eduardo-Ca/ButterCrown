#region CONFIGURACAO
fade = 0;
flash = 1;
estava_ativa = true;
#endregion

#region ANIMACAO
tempo = 0;
hue = random(256);
rotacao = 0;
anel_fase = 0;
#endregion

#region RISCOS DE LUZ
qtd_riscos = 18;
riscos = array_create(qtd_riscos);

for (var i = 0; i < qtd_riscos; i++) {
    riscos[i] = {
        nx: random(1.2),
        ny: random(1),
        comp: random_range(0.08, 0.25),
        larg: random_range(1, 3),
        vel: random_range(0.02, 0.05),
        cor_off: random(256)
    };
}
#endregion