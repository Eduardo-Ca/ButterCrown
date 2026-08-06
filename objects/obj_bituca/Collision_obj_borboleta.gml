if (!assustado) {
    other.energia_atual = min(other.energia_atual + 1, other.energia_maxima);
    
    tocar_som(snd_pulo); 
	criar_texto_flutuante(x, y - 10, "+1", c_lime, 1.2);
	tocar_som(snd_up);
}

event_inherited();
