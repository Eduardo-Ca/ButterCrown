if(!assustado){
	adicionar_log_cadeia("A Borboleta acertou " + nome + ". Gerou " + string(pontos_caos) + " de caos.", 4);
}

#region COLISAO COM BORBOLETA
reagir_impacto_borboleta(id, other, boost_velocidade, pontos_caos, sprite_assustado);
#endregion
