event_inherited();
instance_create_layer(x, y, "Instances", obj_construcao1_destruida);
instance_create_layer(x, y, "Instances", obj_explosao_construcao);


var qtd_fogos = 5;
var inst_fogo = instance_create_layer(0, 0, "Instances", obj_fogos);

for (var i = 0; i < qtd_fogos; i++) {
    array_push(inst_fogo.foguetes, {
        pos_x: x,                               
        pos_y: y,                               
        alvo_y: y - random_range(180, 260),     
        vel_x: random_range(3, 5),             
        vel_y: random_range(10, 15),            
        cor_explosao: choose(c_lime, c_aqua, c_fuchsia, c_yellow, c_orange)
    });
}
