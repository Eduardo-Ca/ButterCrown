#region COLISAO COM OBSTACULO
if (assustado) {
    if (other != id) {
        if (variable_instance_exists(other, "assustado")) {
            other.assustado = true;
        }
        
        global.caos_pontos += pontos_caos / 2;
        
        tremer_tela(5);
        
        instance_destroy();
    }
}
#endregion