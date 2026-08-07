#region COLISAO COM OBSTACULO
if (assustado) {
    if (other != id) {
        if (variable_instance_exists(other, "assustado")) {
			tocar_som(snd_pulo);
            other.assustado = true;
        }
        
        global.caos += pontos_caos / 2;
        
        tremer_tela(5);
        
        instance_destroy();
    }
}
#endregion