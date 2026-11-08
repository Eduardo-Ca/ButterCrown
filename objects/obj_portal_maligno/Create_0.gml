if (!variable_instance_exists(id, "tipo")) tipo = "normal";
if (!variable_instance_exists(id, "atraso")) atraso = 0;

tempo = 0;
duracao = 50;
escala = 0;
giro = 0;

switch (tipo) {
    case "rapida": cor = make_color_rgb(255, 70, 70);  break;
    case "rainha": cor = make_color_rgb(255, 200, 60); break;
    default:       cor = make_color_rgb(190, 60, 255); break;
}
tamanho = (tipo == "rainha") ? 26 : 16;