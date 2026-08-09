tempo_vida--;

var _progresso = tempo_vida / tempo_max;

image_xscale = tamanho_original * _progresso;
image_yscale = image_xscale;
image_alpha = _progresso;

if (tempo_vida <= 0) {
    instance_destroy();
}