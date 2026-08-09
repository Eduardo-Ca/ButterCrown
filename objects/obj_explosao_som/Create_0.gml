#region 
raio = 0;
raio_max = 220;
alpha = 1.0;
distorcao_pontos = 16;
offset_ondas = array_create(distorcao_pontos, 0);

for (var i = 0; i < distorcao_pontos; i++) {
    offset_ondas[i] = random_range(-12, 12);
}
#endregion