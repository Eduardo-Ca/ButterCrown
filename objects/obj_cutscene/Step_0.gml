timer_animacao += 0.04;

if (fade_estado == -1) {
    fade_alpha -= 0.015;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fade_estado = 0;
    }
    exit;
}

if (fade_estado == 2) {
    fade_alpha += 0.015;
    if (fade_alpha >= 1) {
        if (!instance_exists(obj_menu)) {
            instance_create_layer(0, 0, "Instances", obj_menu);
        }
        instance_destroy();
    }
    exit;
}

if (fade_estado == 1) {
    fade_alpha += 0.025;
    if (fade_alpha >= 1) {
        cena_atual++;
        image_index = cena_atual;
        letra_index = 0;
        texto_exibido = "";
        fade_estado = -1;
    }
    exit;
}

var texto_completo = textos[cena_atual];

if (letra_index < string_length(texto_completo)) {
    letra_index += velocidade_texto;
    texto_exibido = string_copy(texto_completo, 1, floor(letra_index));
    
    var caractere_atual = string_char_at(texto_completo, floor(letra_index));
    if (caractere_atual != " " && caractere_atual != "") {
        timer_som++;
        if (timer_som >= 3) {
            tocar_som(snd_pulo);
            timer_som = 0;
        }
    }
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
    if (letra_index < string_length(texto_completo)) {
        letra_index = string_length(texto_completo);
        texto_exibido = texto_completo;
    } 
    else {
        if (cena_atual >= total_cenas - 1) {
            fade_estado = 2;
        } else {
            fade_estado = 1;
        }
    }
}