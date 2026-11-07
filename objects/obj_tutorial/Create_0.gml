#region CONFIGURACAO INTRO
global.pausado = true;

em_intro = true;
frames_por_numero = 40;
etapa_intro = 3;
timer_intro = frames_por_numero;
primeiro_passo = true;
y_inicial = 0;
lancou = false;
habilidades_iniciar_partida();
#endregion

#region CONFIGURACAO TUTORIAL
passo = 0;
timer_passo = 0;
timer_feedback = 0;
alpha = 0;
visivel = false;

textos = [
    "MOUSE ESQUERDO ou ESPAÇO para bater as asas",
    "MOUSE DIREITO solta um vento na direção do mouse",
    "Acerte obstáculos para gerar CAOS e compre upgrades"
];
#endregion