sys_fogos = part_system_create();

part_fogo = part_type_create();
part_type_shape(part_fogo, pt_shape_flare);
part_type_size(part_fogo, 0.2, 0.45, -0.001, 0);
part_type_color3(part_fogo, c_white, c_yellow, c_red);
part_type_alpha3(part_fogo, 1.0, 0.9, 0.0);
part_type_speed(part_fogo, 1, 3.5, -0.02, 0);
part_type_direction(part_fogo, 0, 360, 0, 0);
part_type_gravity(part_fogo, 0.04, 270);
part_type_life(part_fogo, 90, 150);

part_trilha = part_type_create();
part_type_shape(part_trilha, pt_shape_spark);
part_type_size(part_trilha, 0.08, 0.15, -0.001, 0);
part_type_color2(part_trilha, c_yellow, c_orange);
part_type_alpha2(part_trilha, 0.9, 0.0);
part_type_life(part_trilha, 20, 35);

foguetes = [];