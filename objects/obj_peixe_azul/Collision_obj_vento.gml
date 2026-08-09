if(instance_exists(obj_peixe_vermelho)){
	obj_peixe_vermelho.tomar_dano(1);
}
adicionar_log_cadeia("O vento acertou Rei abissal.");
tocar_som(snd_golpe);
criar_texto_flutuante(x, y - 3, "Não me machuque", c_blue, 3);

instance_destroy(other);