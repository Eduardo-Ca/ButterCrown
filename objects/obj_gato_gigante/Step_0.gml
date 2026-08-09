event_inherited();

if(vida_real <= 0){
	if(!morto){
		image_index = 0;
		sprite_index = spr_gato_gigante_morrendo;
		morto = true;
	}

}else{

	#region CRIACAO DE POEIRA NAS PATAS
	tempo_poeira--;

	if (tempo_poeira <= 0) {
	    tempo_poeira = intervalo_poeira;
	    var _offset_x = 0;
    
	    if (choose(true, false)) {
	        _offset_x = random_range(-140, -110);
	    } else {
	        _offset_x = random_range(20, 50);
	    }
    
	    var _offset_y = random_range(70, 80);

	    var _pos_x = x + (_offset_x * image_xscale);
	    var _pos_y = y + _offset_y;
    
	    instance_create_layer(_pos_x-60, _pos_y, "controles", obj_poeira);
	}
	#endregion

	#region TIMER DE PERDA DE VIDA
	timer_dano_continuo--;

	if (timer_dano_continuo <= 0) {
	    timer_dano_continuo = game_get_speed(gamespeed_fps)*3; 
	     tomar_dano(1);
		 #region GERAR BORBOLETAS 

		var _quantidade = irandom(4);
    
		repeat (_quantidade) {
		    var _spawn_x = obj_gato_gigante.x + random_range(200, 290);
        
		    var _spawn_y = obj_gato_gigante.y - random_range(600, 800);
        
		    instance_create_layer(_spawn_x, _spawn_y, "luz", obj_borboleta_maligna);
		}

		#endregion
    
	}
	#endregion


	instance_destroy(obj_obstaculo);

}