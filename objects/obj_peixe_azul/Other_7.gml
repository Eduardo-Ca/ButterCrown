#region TRAVA DE PAUSA 
if (global.pausado) {
    exit;           
}
#endregion
if(!obj_borboleta.morto){
	tocar_som(snd_bolha);
	var _bolha = instance_create_layer(x-10, y, "luz", obj_bolha);
}