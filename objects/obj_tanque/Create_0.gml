event_inherited();
image_xscale = 2;
image_yscale = 2;
cena_chamada = false;

#region BOSS EXERCITO
max_vida = 10;
vida = max_vida;
vida_exibida = max_vida;
nome_boss = "EXERCITO";
#endregion

#region HELICOPTEROS
heli_min = 300;
heli_max = 480;
max_helicopteros = 2;
timer_heli = 150;
#endregion

#region CONFIGURACAO
sprite_index = spr_tanque;
image_speed = 0;

vel_tanque = 0.9;
dist_min = 265;
dist_max = 285;
timer_troca = 0;
alvo_offset = dist_max;

tiro_min = 200;
tiro_max = 320;
aviso_tiro = 40;
timer_tiro = 120;
recuo = 0;

MORTEIRO_X = -202;
MORTEIRO_Y = -70;
#endregion

#region SOLDADOS
soldado_min = 10;
soldado_max = 15;
max_soldados = 7;
timer_soldado = 180;
#endregion

#region TIROS
tiros = [];
duracao_tiro = 55;
gravidade_tiro = 0.2;
trava_mira = 0.35;
tempo_sem_voar = 90;
raio_acerto = 20;
raio_explosao = 35;

explodir_tiro = function(_tx, _ty) {
    tocar_som(snd_explosao);
    tremer_tela(3);
    repeat (12) {
        var _p = instance_create_layer(_tx, _ty, "Instances", obj_poeira);
        _p.cor = choose(c_orange, c_yellow, c_dkgray);
        _p.direction = random(360);
        _p.speed = random_range(1.5, 4);
        _p.tamanho_original = random_range(1, 2.2);
    }
};
#endregion

#region COLOCAR NO CHAO
afundar = 8;

if (instance_exists(obj_chao)) {
    var _base = (sprite_get_bbox_bottom(sprite_index) + 1 - sprite_get_yoffset(sprite_index)) * image_yscale;
    y = obj_chao.bbox_top - _base + afundar;
    depth = obj_chao.depth + 1;
}
#endregion