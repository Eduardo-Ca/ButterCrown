if (!instance_exists(obj_loja) && !(instance_exists(obj_tutorial) && obj_tutorial.em_intro)) {
    global.pausado = !global.pausado;
    pausa_sel = 0;
    if (!global.pausado) mouse_clear(mb_left);
}
