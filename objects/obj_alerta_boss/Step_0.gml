#region TRAVA DE PAUSA 
if (global.pausado) {
    exit;           
}
#endregion

tempo_vida -= 1;
tempo_pisca += 0.1;

if (escala < 1) {
    escala = lerp(escala, 1, 0.1);
}

if (tempo_vida <= 0) {
    instance_destroy();
}