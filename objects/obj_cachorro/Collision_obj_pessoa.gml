#region REAÇÃO EM CADEIA DE ASSUSTAR OUTRA PESSOA

if (assustado) {
    if (other != id) {

        if (!other.assustado) {

            other.assustado = true;
            other.sprite_index = other.sprite_assustado;
            
            global.caos += pontos_caos/4;
            
            tremer_tela(2);
        }
    }
}
#endregion