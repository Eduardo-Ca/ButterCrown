randomise();

#region VARIAVEIS GLOBAIS DO MUNDO
global.caos = 0;
global.pausado = false;
global.clima = "";
global.periodo = "";
global.logs_eventos = [];

global.tutorial_concluido = false;
global.cena_bomba = false;
#endregion

#region CONFIGURACOES VELOCIDADE MUNDO
global.vel_mundo = 2;
global.velocidade_maxima_base = 5;
global.velocidade_maxima = global.velocidade_maxima_base;
global.vel_minima_parada = 0.2;
global.atrito_ar = 0.005;
global.atrito_chao = 0.06;
global.distancia_percorrida = 0;
global.recorde_distancia = 0;

#endregion

#region upgrade
#region NIVEIS DOS UPGRADES DA LOJA
global.upg_energia_nivel = 0;
global.upg_impulso_nivel = 0;
global.upg_quiques_nivel = 0;
global.upg_boost_nivel = 0;
global.upg_limite_vel_nivel = 0;
global.upg_vel_inicial_nivel = 0;
global.upg_balao_nivel = 0;
global.upg_pessoa_nivel = 0;
global.upg_predio_nivel = 0;
global.upg_perigo_nivel = 0;

global.hab_meteoro_nivel = 0;
global.hab_dobra_nivel = 0;
global.hab_sapo_nivel = 0;
global.hab_tornado_nivel = 0;
#endregion

#region VALORES BASE E BÔNUS POR NÍVEL
global.energia_max_base = 5;
global.energia_max_por_nivel = 1;

global.impulso_base = -2.5;
global.impulso_por_nivel = -1;

global.quiques_max_base = 2;
global.quiques_max_por_nivel = 1;

global.boost_base = 0.8;
global.boost_por_nivel = 0.2;

global.vel_max_por_nivel = 1;

global.vel_inicial_base = 2.0;      
global.vel_inicial_por_nivel = 1;
#endregion

#region MODIFICADORES DE SPAWN
global.chance_bonus_mult = 1;
global.chance_perigo_mult = 1;
global.spawn_freq_mult = 1;
#endregion

#region MODIFICADORES DE SPAWN
global.chance_bonus_mult = 1;
global.chance_perigo_mult = 1;
global.spawn_freq_mult = 1;
global.spawn_mult = {};
#endregion

#region CARREGAR SAVE
carregar_jogo();
#endregion

#region STATUS FINAIS
habilidades_definir();
recalcular_status();
global.vel_mundo = global.vel_inicial_atual;
#endregion

#endregion