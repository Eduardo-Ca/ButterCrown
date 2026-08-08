randomise();

#region VARIAVEIS GLOBAIS DO MUNDO
global.caos = 0;
global.pausado = false;
global.clima = "";
global.periodo = "";
global.logs_eventos = [];
#endregion

#region CONFIGURACOES VELOCIDADE MUNDO
global.vel_mundo = 2;
global.velocidade_maxima_base = 5;
global.velocidade_maxima = global.velocidade_maxima_base;
global.vel_minima_parada = 0.2;
global.atrito_ar = 0.005;
global.atrito_chao = 0.06;
global.distancia_percorrida = 0;
#endregion

#region upgrade
#region NIVEIS DOS UPGRADES DA LOJA
global.upg_energia_nivel = 0;
global.upg_impulso_nivel = 0;
global.upg_quiques_nivel = 0;
global.upg_boost_nivel = 0;
global.upg_limite_vel_nivel = 0;
global.upg_vel_inicial_nivel = 0;
#endregion

#region VALORES BASE E BÔNUS POR NÍVEL
global.energia_max_base = 5;
global.energia_max_por_nivel = 1;

global.impulso_base = -2.6;
global.impulso_por_nivel = -0.6;

global.quiques_max_base = 2;
global.quiques_max_por_nivel = 1;

global.boost_base = 0.8;
global.boost_por_nivel = 0.2;

global.vel_max_por_nivel = 1;

global.vel_inicial_base = 2.0;      
global.vel_inicial_por_nivel = 0.5;
#endregion

#region STATUS FINAIS 
global.energia_maxima = global.energia_max_base + (global.upg_energia_nivel * global.energia_max_por_nivel);
global.forca_impulso = global.impulso_base + (global.upg_impulso_nivel * global.impulso_por_nivel);
global.quiques_maximos = global.quiques_max_base + (global.upg_quiques_nivel * global.quiques_max_por_nivel);
global.boost_por_impulso = global.boost_base + (global.upg_boost_nivel * global.boost_por_nivel);
global.velocidade_maxima = global.velocidade_maxima_base + (global.upg_limite_vel_nivel * global.vel_max_por_nivel);
global.vel_inicial_atual = global.vel_inicial_base + (global.upg_vel_inicial_nivel * global.vel_inicial_por_nivel);
global.vel_mundo         = global.vel_inicial_atual;

#endregion
#endregion