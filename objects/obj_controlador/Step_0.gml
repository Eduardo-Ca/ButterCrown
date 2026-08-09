if (global.pausado) exit;

#region GERENCIAMENTO DO MUNDO
if (instance_exists(obj_borboleta) && !obj_borboleta.morto) {
    if (global.vel_mundo > 0) {
        global.vel_mundo = max(0, global.vel_mundo - global.atrito_ar);
    }
    
    if (!instance_exists(obj_boss)) {
        global.distancia_percorrida += global.vel_mundo * 0.05;
		if (global.distancia_percorrida > global.recorde_distancia) {
		    global.recorde_distancia = floor(global.distancia_percorrida);
		}
		#endregion;
    }
} else {
    global.vel_mundo = lerp(global.vel_mundo, 0, 0.1);
}
#endregion

for (var i = array_length(global.logs_eventos) - 1; i >= 0; i--) {
    global.logs_eventos[i].timer--;
    
    if (global.logs_eventos[i].timer <= 0) {
        array_delete(global.logs_eventos, i, 1);
    }
}

if(instance_exists(obj_loja)){
	global.pausado = false;	
}



