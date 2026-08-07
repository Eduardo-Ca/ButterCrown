#region CONFIGURACOES E FISICA (PUXANDO DAS GLOBAIS DE UPGRADE)
posicao_x_base = 230;
vel_vertical = 0;
gravidade = 0.09;      
forca_impulso = global.forca_impulso;         
energia_maxima = global.energia_maxima;
energia_atual = energia_maxima;
retorno_x_velocidade = 0.04;
boost_por_impulso = global.boost_por_impulso;
#endregion

#region SISTEMA DE QUIQUES (PUXANDO DAS GLOBAIS DE UPGRADE)
quiques_maximos = global.quiques_maximos + 500;
quiques_atuais = quiques_maximos;
forca_quique = -2.8 + global.quiques_maximos/10;          
tempo_recarrega_quiques = 120;
timer_recupera_quiques = 0;
tempo_flutuacao = 0;
#endregion

#region ESTADO GERAL
morto = false;
#endregion

#region COOLDOWN HABILIDADE VENTO
cooldown_vento_max = 40; 
cooldown_vento_timer = 0;
vento_disparado = false;
timer_rastro = 0;
#endregion

