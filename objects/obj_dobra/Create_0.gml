#region CONFIGURACAO
fade = 0;
flash = 1;
estava_ativa = true;
tempo_shader = 0;
#endregion

#region UNIFORMS DO SHADER
u_tempo = shader_get_uniform(sh_dobra, "u_tempo");
u_forca = shader_get_uniform(sh_dobra, "u_forca");
u_centro = shader_get_uniform(sh_dobra, "u_centro");
u_aspecto = shader_get_uniform(sh_dobra, "u_aspecto");
#endregion