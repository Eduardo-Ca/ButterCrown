#region REAÇÃO EM CADEIA DE ASSUSTAR 

if (assustado) {
    if (other != id) {

        if (!other.assustado) {

            other.assustado = true;
            other.sprite_index = other.sprite_assustado;
            
            global.caos += pontos_caos/5;
            
        }
    }
}
#endregion