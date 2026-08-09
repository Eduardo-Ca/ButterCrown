vida_exibida = lerp(vida_exibida, vida, 0.1);

if (tempo_flash_dano > 0) tempo_flash_dano--;
escala_dano = lerp(escala_dano, 1.0, 0.15);

if (destruindo) {
    alpha_morte = lerp(alpha_morte, 0, 0.08);
    escala_morte += 0.03; 
    y -= 0.5; 
    
    x += random_range(-2, 2);
    
    if (alpha_morte <= 0.05) {
        instance_destroy();
    }
}