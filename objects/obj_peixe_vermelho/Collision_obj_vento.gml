tomar_dano(1);
adicionar_log_cadeia("O vento acertou Rei abissal.");
tocar_som(snd_golpe);
criar_texto_flutuante(x, y - 3, "Maldito", c_orange, 3);

instance_destroy(other);