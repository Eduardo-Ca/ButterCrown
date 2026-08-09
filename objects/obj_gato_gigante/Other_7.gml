#region EXPLOSAO DE SOM
instance_create_depth(x, y, depth - 20, obj_explosao_som);

if (!audio_is_playing(snd_miau)) {
    tocar_som(snd_miau);
}
#endregion

if(morto){
	obj_borboleta.energia_atual = 0;
    obj_borboleta.vel_vertical = 0;
	obj_borboleta.quiques_atuais = 0;
	obj_borboleta.quiques_maximos = 0;
	obj_borboleta.forca_quique = 0;
    global.vel_mundo = 0;	
	
	instance_destroy();
}


