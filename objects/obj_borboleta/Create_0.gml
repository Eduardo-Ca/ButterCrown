#region CONFIGURACOES E FISICA 
posicao_x_base = 150;
vel_vertical = 0;
gravidade = 0.09;      
forca_impulso = global.forca_impulso;         
energia_maxima = global.energia_maxima;
energia_atual = global.energia_maxima; 

retorno_x_velocidade = 0.04;
boost_por_impulso = global.boost_por_impulso;

afetado_por_onda = false;
tempo_reset_onda = 20; 

#region AVISO DE ENERGIA
energia_anterior = energia_atual;
#endregion
#endregion

#region SISTEMA DE QUIQUES
quiques_maximos = global.quiques_maximos;
quiques_atuais = 0; 

forca_quique = -2.8 + global.quiques_maximos / 10;          
tempo_recarrega_quiques = 160;
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

#region poderes obstaculos

#region MODO FOGUETE
modo_foguete = false;
timer_foguete = 0;
foguete_duracao = 65;
foguete_lancamento = 15;
foguete_vel_max = 11;
foguete_vel_mundo = 1.4;
y_foguete_ini = 0;
ang_foguete = 0;
#endregion

#region MODO METEORO
modo_meteoro = false;
timer_meteoro = 0;
meteoro_vel_max = 22;
meteoro_raio = 420;
meteoro_quique = -9;
meteoro_alvo = noone;
#endregion

#region MODO DOBRA
modo_dobra = false;
timer_dobra = 0;
dobra_duracao = 150;
dobra_vel_mundo = 3;
dobra_y_base = 0;
dobra_off = 0;
dobra_off_alvo = 0;
dobra_troca = 0;
dobra_amplitude = 70;
#endregion

#endregion