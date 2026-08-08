draw_set_font(Font1);
cena_atual = 0;
total_cenas = 4;

image_speed = 0;
image_index = 0;

textos[0] = "Dizem que o simples bater de asas de uma borboleta pode causar um tornado do outro lado do mundo...";
textos[1] = "No entanto, a desordem real exige um toque de poder muito mais sombrio...";
textos[2] = "Minhas candidatas... Vocês foram escolhidas para espalhar o caos supremo por todo o multiverso!";
textos[3] = "Aquele que causar a maior destruicão e subir mais alto... herdará a Coroa e se tornara o REI DO CAOS!";

texto_exibido = "";
letra_index = 0;
velocidade_texto = 0.25;
timer_som = 0;

fade_alpha = 1.0;
fade_estado = -1;
timer_animacao = 0;