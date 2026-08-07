
event_inherited();

if(assustado){
	with (other) {
		criar_texto_flutuante(obj_borboleta.x, obj_borboleta.y - 10, "-1", c_red, 3);
		if (audio_exists(snd_sem_energia)) {
			tocar_som(snd_sem_energia);
		}

		energia_atual = max(0, energia_atual - 1);
	}
}