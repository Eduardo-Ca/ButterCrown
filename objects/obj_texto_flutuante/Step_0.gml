#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion

#region ATUALIZACAO DO MOVIMENTO E TRANSPARENCIA

y += vel_y;
vel_y = min(vel_y + gravidade_texto, 0); 

timer -= 1;
alpha = timer / tempo_vida;

if (timer <= 0) {
    instance_destroy();
}
#endregion