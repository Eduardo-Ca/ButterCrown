#region BARRA DE COOLDOWN
draw_self();

if (cooldown_vento_timer > 0 && !morto) {
    var pct = 1 - (cooldown_vento_timer / cooldown_vento_max);
    
    var bar_w = 32;
    var bar_h = 4;
    var bx = x - (bar_w / 2);
    var by = y - 35; 
    
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(bx - 1, by - 1, bx + bar_w + 1, by + bar_h + 1, false);
    
    draw_set_color(c_aqua);
    draw_set_alpha(0.9);
    draw_rectangle(bx, by, bx + (bar_w * pct), by + bar_h, false);
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
#endregion