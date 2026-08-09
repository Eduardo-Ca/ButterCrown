#region ATUALIZACAO DAS ONDAS E DISTORCAO
raio = lerp(raio, raio_max, 0.2);
alpha = lerp(alpha, 0, 0.08);

for (var i = 0; i < distorcao_pontos; i++) {
    offset_ondas[i] = random_range(-15, 15) * alpha;
}

if (alpha <= 0.02) {
    instance_destroy();
}
#endregion

#region EMPURRAR BORBOLETA NO RAIO DA ONDA
with (obj_borboleta) {
    var _dist = point_distance(other.x, other.y, x, y);
    
    if (_dist <= other.raio) {
        if (!variable_instance_exists(id, "afetado_por_onda") || !afetado_por_onda) {
			energia_atual = min(energia_atual + 1, energia_maxima);
			criar_texto_flutuante(x, y - 10, "+1", c_lime, 3);
            vel_vertical = -4;
            image_xscale = 1.4;
            image_yscale = 0.6;
            afetado_por_onda = true;
			global.vel_mundo = clamp(global.vel_mundo + 0.3, 0, global.velocidade_maxima);
        }
    }
}

with (obj_obstaculo) {
    var _dist = point_distance(other.x, other.y, x, y);
    
    if (_dist <= other.raio) {
		instance_destroy();
    }
}
#endregion