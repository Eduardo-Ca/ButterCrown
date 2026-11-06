#region INTRO
if (em_intro) {
    if (primeiro_passo) {
        primeiro_passo = false;
        y_inicial = obj_borboleta.y;

        var _tx = obj_borboleta.x - (obj_camera.largura_base / 2);
        var _ty = obj_borboleta.y - (obj_camera.altura_base / 2);
        obj_camera.x = _tx;
        obj_camera.y = _ty;
        camera_set_view_pos(view_camera[0], _tx, _ty);
    }

    obj_borboleta.y = y_inicial + sin(current_time * 0.006) * 4;
    obj_borboleta.image_index = (obj_borboleta.image_index + 0.2) mod obj_borboleta.image_number;

    timer_intro--;
    if (timer_intro <= 0) {
        etapa_intro--;
        if (etapa_intro > 0) {
            timer_intro = frames_por_numero;
            tocar_som(snd_up);
        } else if (etapa_intro == 0) {
            timer_intro = 25;
            tocar_som(snd_vento);
        } else {
            obj_borboleta.y = y_inicial;
            global.pausado = false;
            em_intro = false;
        }
    }
    exit;
}
#endregion

#region TRAVAS
if (global.tutorial_concluido) exit;
if (global.pausado || instance_exists(obj_loja) || instance_exists(obj_boss)) exit;
if (!instance_exists(obj_borboleta) || obj_borboleta.morto) exit;
#endregion

#region PROGRESSAO
timer_passo++;
visivel = (timer_passo > 40);

if (global.distancia_percorrida > 500) {
    concluir_tutorial();
    exit;
}

if (timer_feedback > 0) {
    timer_feedback--;
    if (timer_feedback <= 0) {
        passo++;
        timer_passo = 0;
        if (passo >= array_length(textos)) {
            concluir_tutorial();
            exit;
        }
    }
} else if (visivel) {
    switch (passo) {
        case 0:
            if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) timer_feedback = 50;
            break;
        case 1:
            if (mouse_check_button_pressed(mb_right)) timer_feedback = 50;
            break;
        case 2:
            if (global.caos >= 1) timer_feedback = 50;
            break;
    }
}
#endregion