repeat (4) {
    var _parte = instance_create_layer(x, y, "luz", obj_pedaco);
    _parte.image_blend = cor;
}
tocar_som(snd_estrela);

if (morta_pelo_jogador) {
    var _pts = (tipo == "rainha") ? 3 : 1;
    global.caos += _pts;
    criar_texto_flutuante(x, y - 10, "+" + string(_pts), c_lime, 2);
}