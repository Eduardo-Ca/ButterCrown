#region LIMPEZA DAS VARIAVEIS GLOBAIS
if (modo_fundo) exit;

if (variable_global_exists("clima")) {
    global.clima = "";
}
if (variable_global_exists("periodo")) {
    global.periodo = "";
}
#endregion