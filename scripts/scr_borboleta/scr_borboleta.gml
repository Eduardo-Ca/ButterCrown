function reagir_impacto_borboleta(_inst_obstaculo, _inst_borboleta, _boost_vel, _pontos_caos, _sprite_fuga = noone) {
    with (_inst_obstaculo) {
        if (!_inst_borboleta.morto ) {

            tremer_tela(6);
            _inst_borboleta.vel_vertical = -5.5;
            _inst_borboleta.image_xscale = 1.4;
            _inst_borboleta.image_yscale = 0.6;
            _inst_borboleta.quiques_atuais = 0;
            
            global.vel_mundo = clamp(global.vel_mundo + _boost_vel, 0, global.velocidade_maxima);
            global.caos_pontos += _pontos_caos;
            
            assustado = true;
            if (_sprite_fuga != noone) {
                sprite_index = _sprite_fuga;
            }
        }
    }
}