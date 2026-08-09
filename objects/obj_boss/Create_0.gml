max_vida = 1;
vida = max_vida;
nome_boss = "CHEFE";
vida_exibida = max_vida;
eh_boss_secundario = false;

tempo_flash_dano = 0;
escala_dano = 1.0;
destruindo = false;
alpha_morte = 1.0;
escala_morte = 1.0;

#region FUNÇÃO PARA TOMAR DANO
function tomar_dano(_quantidade) {
    if (destruindo) exit;
    
    vida -= _quantidade;
    tempo_flash_dano = 8; 
    escala_dano = 1.25; 
    
    if (vida <= 0) {
        vida = 0;
        iniciar_morte();
    }
}
#endregion

#region FUNÇÃO PARA INICIAR MORTE
function iniciar_morte() {
    if (destruindo) exit;
    destruindo = true;
    
    mask_index = -1;
}
#endregion