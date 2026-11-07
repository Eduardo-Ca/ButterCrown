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

#region ANIMACAO
tempo++;
hue = (hue + 3) mod 256;
rotacao += 1.5;
anel_fase = (anel_fase + 0.04) mod 1;
#endregion

#region RISCOS DE LUZ
for (var i = 0; i < qtd_riscos; i++) {
    var _r = riscos[i];
    _r.nx -= _r.vel;

    if (_r.nx + _r.comp < 0) {
        _r.nx = 1 + random(0.3);
        _r.ny = random(1);
        _r.comp = random_range(0.08, 0.25);
        _r.vel = random_range(0.02, 0.05);
    }
}
#endregion