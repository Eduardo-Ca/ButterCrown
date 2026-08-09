if (global.pausado) exit;
if (!assustado) {
    other.energia_atual = min(other.energia_atual + -1, other.energia_maxima);
    
	criar_texto_flutuante(x, y - 10, "-1", c_red, 3);
	tocar_som(snd_sem_energia);
}

event_inherited();
