#region FUNCOES PUBLICAS DE CAMERA
function tremer_tela(_forca) {
    if (instance_exists(obj_camera)) {
        obj_camera.shake_intensidade = min(obj_camera.shake_intensidade + _forca, 16);
    }
}
#endregion