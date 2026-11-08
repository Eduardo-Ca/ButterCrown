if(instance_exists(obj_peixe_vermelho)){
	obj_peixe_vermelho.tomar_dano(1);
}
adicionar_log_cadeia("O vento acertou Rei abissal.");
tocar_som(snd_golpe);


instance_destroy(other);