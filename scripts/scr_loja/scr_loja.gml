#region STATUS DOS UPGRADES
function mult_balao(_n) { return 1 + _n * 0.10; }
function mult_pessoa(_n) { return 1 + _n * 0.10; }
function mult_fogos(_n) { return 1 + _n * 0.15; }
function mult_perigo(_n) { return max(0.6, 1 - _n * 0.08); }

function recalcular_status() {
    global.energia_maxima = global.energia_max_base + (global.upg_energia_nivel * global.energia_max_por_nivel);
    global.forca_impulso = global.impulso_base + (global.upg_impulso_nivel * global.impulso_por_nivel);
    global.quiques_maximos = global.quiques_max_base + (global.upg_quiques_nivel * global.quiques_max_por_nivel);
    global.boost_por_impulso = global.boost_base + (global.upg_boost_nivel * global.boost_por_nivel);
    global.velocidade_maxima = global.velocidade_maxima_base + (global.upg_limite_vel_nivel * global.vel_max_por_nivel);
    global.vel_inicial_atual = global.vel_inicial_base + (global.upg_vel_inicial_nivel * global.vel_inicial_por_nivel);

	global.chance_perigo_mult = mult_perigo(global.upg_perigo_nivel);
	global.spawn_mult.balao = mult_balao(global.upg_balao_nivel);
	global.spawn_mult.pessoa = mult_pessoa(global.upg_pessoa_nivel);
	global.spawn_mult.construcao = mult_fogos(global.upg_predio_nivel);
	habilidades_atualizar_slots();

}
#endregion