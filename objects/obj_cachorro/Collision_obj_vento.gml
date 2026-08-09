event_inherited();
if(!assustado){
	var caos_gerado = 1;
    global.caos += caos_gerado;        
	adicionar_log_cadeia("O vento acertou " + nome + ". Gerou " + string(caos_gerado) + " de caos.", 4);
	obj_borboleta.energia_atual = min(obj_borboleta.energia_atual + +1, obj_borboleta.energia_maxima);
	criar_texto_flutuante(x, y - 10, "+1", c_lime, 3);
	tocar_som(snd_up);
	assustado = true;
}else{
	instance_destroy();
}