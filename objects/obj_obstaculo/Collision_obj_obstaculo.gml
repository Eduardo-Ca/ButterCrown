if (assustado) {
    if (!other.assustado) {
        other.assustado = true;
        other.sprite_index = other.sprite_assustado;            
        
        var caos_gerado = pontos_caos / 4;
        global.caos += caos_gerado;            
        
        var txt_caos = (caos_gerado == floor(caos_gerado)) ? string(floor(caos_gerado)) : string_format(caos_gerado, 0, 1);
        
        adicionar_log_cadeia(nome + " acertou " + other.nome + ". Gerou " + txt_caos + " de caos.", 4);
    }
}