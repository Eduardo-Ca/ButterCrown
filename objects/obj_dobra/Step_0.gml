#region TRAVA DE PAUSA
if (global.pausado) exit;
#endregion

#region FADE E FLASH
var _ativa = instance_exists(obj_borboleta) && obj_borboleta.modo_dobra;

fade = lerp(fade, _ativa ? 1 : 0, _ativa ? 0.12 : 0.08);

if (estava_ativa && !_ativa) flash = 1;
estava_ativa = _ativa;
flash = max(0, flash - 0.06);

if (!_ativa && fade < 0.02 && flash <= 0) {
    instance_destroy();
    exit;
}
#endregion

#region TEMPO DO SHADER
tempo_shader += 1 / 60;
#endregion