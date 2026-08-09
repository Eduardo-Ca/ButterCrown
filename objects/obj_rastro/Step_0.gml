#region TRAVA DE PAUSA 
if (global.pausado) {
    image_speed = 0; 
    exit;           
} else {
    image_speed = 1;
}
#endregion

#region E DESAPARECIMENTO

image_alpha -= taxa_desaparecimento;
image_xscale *= taxa_encolhimento;
image_yscale *= taxa_encolhimento;

if (image_alpha <= 0) {
    instance_destroy();
}
#endregion