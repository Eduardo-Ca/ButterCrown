#region ESPERA E ABRE A LOJA APOS A MORTE
if (instance_exists(obj_borboleta)) {

    if (obj_borboleta.morto && timer_abrir_loja == -1) {
    
        timer_abrir_loja = 120; 
    }
}


if (timer_abrir_loja > 0) {
    timer_abrir_loja--;
    
    if (timer_abrir_loja == 0) {
        if (!instance_exists(obj_loja)) {
            instance_create_layer(0, 0, "Instances", obj_loja);
        }
    }
}
#endregion