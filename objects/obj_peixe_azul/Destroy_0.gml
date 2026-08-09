if(!obj_borboleta.morto){
	tocar_som(snd_bolha);
	repeat(6){
		var _bolha = instance_create_layer(x + irandom_range(-15,15), y+ irandom_range(-6,6), "luz", obj_bolha);
	}
}