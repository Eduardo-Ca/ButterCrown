if (global.pausado) exit;
draw_set_color(c_white);
draw_set_alpha(0.15);

var tempo = current_time * 0.05;
for (var i = 0; i < 6; i++) {
    var vx = (tempo * (4 + i) + i * 200) mod (room_width + 100) - 50;
    var vy = (i * 110 + 60) mod room_height;
    draw_line_width(vx, vy, vx + 40 + (global.vel_mundo * 5), vy, 2);
}

draw_set_alpha(1);