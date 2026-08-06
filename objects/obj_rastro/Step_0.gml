#region TRAVA DE PAUSA E DESAPARECIMENTO
if (global.pausado) exit;

image_alpha -= taxa_desaparecimento;
image_xscale *= taxa_encolhimento;
image_yscale *= taxa_encolhimento;

if (image_alpha <= 0) {
    instance_destroy();
}
#endregion