if(!obj_borboleta.morto){
	tocar_som(snd_bolha);
	repeat(8){
		var _bolha = instance_create_layer(x + irandom_range(-35,35), y+ irandom_range(-15,15), "luz", obj_bolha);
	}
}