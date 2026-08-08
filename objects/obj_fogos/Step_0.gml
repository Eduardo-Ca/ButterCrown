for (var i = array_length(foguetes) - 1; i >= 0; i--) {
    var f = foguetes[i];
    
    f.pos_x += f.vel_x;
    f.pos_y -= f.vel_y;
    
    f.vel_y -= 0.12; 
    
    part_particles_create(sys_fogos, f.pos_x, f.pos_y, part_trilha, 2);
    
    if (f.pos_y <= f.alvo_y || f.vel_y <= 0) {
		tocar_som(snd_explosao);
        part_type_color2(part_fogo, c_white, f.cor_explosao);
        part_particles_create(sys_fogos, f.pos_x, f.pos_y, part_fogo, 100);
        
        array_delete(foguetes, i, 1);
    }
}

if (array_length(foguetes) == 0 && part_particles_count(sys_fogos) == 0) {
    instance_destroy();
}