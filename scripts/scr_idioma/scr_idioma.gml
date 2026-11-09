function idioma_iniciar() {
    global.idioma = "pt";
    global.traducao = {};

    var _pares = [
        // MENU
        ["JOGAR", "PLAY"], ["CONTINUAR", "CONTINUE"], ["NOVO JOGO", "NEW GAME"], ["MENU PRINCIPAL", "MAIN MENU"],
        ["Começar um novo jogo?", "Start a new game?"], ["Seu progresso atual será apagado.", "Your current progress will be erased."],
        ["SIM, APAGAR", "YES, ERASE"], ["CANCELAR", "CANCEL"], ["TUTORIAL", "TUTORIAL"], ["SAIR", "QUIT"],
        ["COMO JOGAR", "HOW TO PLAY"], ["CONTROLES", "CONTROLS"], ["DICAS", "TIPS"],
        ["Voar / dar impulso", "Fly / boost"], ["Bater asas (vento)", "Flap wings (wind)"],
        ["Pausar", "Pause"], ["Usar poderes", "Use powers"], ["ENTENDI!", "GOT IT!"],
        ["Pule em balões e pessoas para subir mais alto!", "Bounce on balloons and people to fly higher!"],
        ["Afaste as bombas com o vento!", "Blow the bombs away with wind!"],
        ["Cada impulso gasta energia. Use com cuidado!", "Each boost uses energy. Be careful!"],
        ["Cause caos e gaste na loja com upgrades!", "Cause chaos and spend it on upgrades!"],
        ["RECORDE: ", "BEST: "], ["ÚLTIMA: ", "LAST: "],

        // CUTSCENE
        ["Dizem que o simples bater de asas de uma borboleta pode causar um tornado do outro lado do mundo...", "They say the simple flap of a butterfly's wings can cause a tornado on the other side of the world..."],
        ["No entanto, a desordem real exige um toque de poder muito mais sombrio...", "However, true disorder demands a touch of far darker power..."],
        ["Minhas candidatas... Vocês foram escolhidas para espalhar o caos supremo por todo o multiverso!", "My candidates... You have been chosen to spread supreme chaos across the entire multiverse!"],
        ["Aquele que causar a maior destruição e subir mais alto... herdará a Coroa e se tornará o REI DO CAOS!", "Whoever causes the most destruction and flies the highest... will inherit the Crown and become the KING OF CHAOS!"],
        ["NARRADOR", "NARRATOR"], ["Segure ESC para pular", "Hold ESC to skip"],

        // JOGO
        ["JOGO PAUSADO", "GAME PAUSED"], ["Pressione ESC para Voltar", "Press ESC to Resume"],
        ["--- REAÇÕES EM CADEIA ---", "--- CHAIN REACTIONS ---"],
        ["CAOS: ", "CHAOS: "], ["CAOS", "CHAOS"], ["APOCALIPSE", "APOCALYPSE"],
        ["FASE ", "STAGE "], ["PRAIA", "BEACH"], ["CIDADE", "CITY"], ["ONDA ", "WAVE "],
        ["SEM VOAR!", "CAN'T FLY!"], ["VOAR!", "FLY!"], ["BOA!", "NICE!"],
        ["MOUSE ESQUERDO ou ESPAÇO para bater as asas", "LEFT MOUSE or SPACE to flap your wings"],
        ["MOUSE DIREITO solta um vento na direção do mouse", "RIGHT MOUSE blows wind toward the cursor"],
        ["Acerte obstáculos para gerar CAOS e compre upgrades", "Hit obstacles to create CHAOS and buy upgrades"],

        // BOSSES
        ["ALERTA DE BOSS!", "BOSS ALERT!"], ["UM NOVO INIMIGO APARECEU", "A NEW ENEMY HAS APPEARED"],
        ["CHEFE", "BOSS"], ["REIS ABISSAIS", "ABYSSAL KINGS"], ["A AMEAÇA DOS MARES", "THE MENACE OF THE SEAS"],
        ["PROTEJA O GATO DAS BORBOLETAS DO CAOS", "PROTECT THE CAT FROM THE BUTTERFLIES OF CHAOS"],
        ["BORBOLETAS DO CAOS", "BUTTERFLIES OF CHAOS"], ["SOBREVIVA!", "SURVIVE!"],
        ["PROTEJA O GATO DAS FADAS!", "PROTECT THE CAT FROM THE FAIRIES!"],
        ["O EXERCITO CHEGOU", "THE ARMY HAS ARRIVED"], ["DERRUBE OS HELICOPTEROS", "SHOOT DOWN THE HELICOPTERS"],
        ["EXERCITO", "ARMY"],

        // LOJA
        ["LOJA DE UPGRADES", "UPGRADE SHOP"], ["NOVO RECORDE!", "NEW RECORD!"], ["MÁX", "MAX"],
        ["EM BREVE", "COMING SOON"], ["Novas habilidades chegando", "New abilities coming"],
        ["JOGAR NOVAMENTE", "PLAY AGAIN"], ["ENTER  JOGAR", "ENTER  PLAY"],
        ["Q / E ABA   RODA: ROLAR", "Q / E TAB   WHEEL: SCROLL"], ["Q / E  TROCAR ABA", "Q / E  SWITCH TAB"],
        ["MOVIMENTO", "MOVEMENT"], ["SORTE", "LUCK"], ["HABILIDADES", "ABILITIES"],
        [" uso", " use"], [" usos", " uses"],
        ["Energia Máxima", "Max Energy"], ["Mais batidas de asa por voo", "More wing flaps per flight"],
        ["Limite de Velocidade", "Speed Limit"], ["Velocidade máxima do mundo", "Maximum world speed"],
        ["Qtd. de Quiques", "Bounce Count"], ["Quiques no chão antes de cair", "Ground bounces before falling"],
        ["Boost Velocidade", "Speed Boost"], ["Velocidade ganha a cada impulso", "Speed gained with each boost"],
        ["Força do Impulso", "Boost Power"], ["Altura de cada batida de asa", "Height of each wing flap"],
        ["Impulso Inicial", "Starting Boost"], ["Velocidade ao começar o voo", "Speed when starting a flight"],
        ["Mais Balões", "More Balloons"], ["Balões aparecem com mais frequência", "Balloons appear more often"],
        ["Mais Pessoas", "More People"], ["Mais pessoas para quicar no chão", "More people to bounce on"],
        ["Mais Lojas de Fogos", "More Fireworks Shops"], ["Lojas de fogos dão grande impulso", "Fireworks shops give a big boost"],
        ["Perigos Raros", "Rare Dangers"], ["Menos bombas, pássaros e cachorros", "Fewer bombs, birds and dogs"],
        ["Meteoro", "Meteor"], ["Mergulha e destrói tudo", "Dives and destroys everything"],
        ["Dobra", "Warp"], ["Dash dimensional que esmaga tudo", "Dimensional dash that crushes everything"],
        ["Sapo Mago", "Wizard Frog"], ["Invoca um amigo que cria nuvens", "Summons a friend who creates clouds"],
        ["Fúria dos Ventos", "Wind Fury"], ["Cresce e solta vários tornados", "Grows and releases several tornadoes"]
    ];

    for (var i = 0; i < array_length(_pares); i++) {
        global.traducao[$ _pares[i][0]] = _pares[i][1];
    }

    // ordem importa: frases maiores primeiro
    global.frases_log = [
        [" usos", " uses"], [" uso", " use"],
        ["O vento acertou ", "The wind hit "], ["A Borboleta acertou ", "The Butterfly hit "],
        ["Borboleta derrotou ", "Butterfly defeated "], [" acertou ", " hit "],
        [". Gerou ", ". Generated "], [" de caos.", " chaos."],
        ["Rei abissal", "Abyssal King"], ["REIS ABISSAIS", "ABYSSAL KINGS"], ["BORBOLETAS DO CAOS", "BUTTERFLIES OF CHAOS"],
        ["EXERCITO", "ARMY"], ["CHEFE", "BOSS"], ["Balão explosivo", "Explosive Balloon"], ["Balão", "Balloon"],
        ["Gata Mágica", "Magic Cat"], ["Bolha", "Bubble"], ["Cachorro", "Dog"], ["Estrela", "Star"],
        ["Loja", "Fireworks Shop"], ["Obstáculo", "Obstacle"], ["Pássaro", "Bird"], ["Pessoa", "Person"], ["Soldado", "Soldier"]
    ];

    ini_open("config.ini");
    global.idioma = ini_read_string("jogo", "idioma", "pt");
    ini_close();
}

function tr(_txt) {
    if (!variable_global_exists("idioma")) idioma_iniciar();
    if (global.idioma == "pt") return _txt;

    var _en = global.traducao[$ _txt];
    return is_undefined(_en) ? _txt : _en;
}

function tr_log(_txt) {
    if (!variable_global_exists("idioma")) idioma_iniciar();
    if (global.idioma == "pt") return _txt;

    for (var i = 0; i < array_length(global.frases_log); i++) {
        _txt = string_replace_all(_txt, global.frases_log[i][0], global.frases_log[i][1]);
    }
    return _txt;
}

function idioma_alternar() {
    if (!variable_global_exists("idioma")) idioma_iniciar();
    global.idioma = (global.idioma == "pt") ? "en" : "pt";

    ini_open("config.ini");
    ini_write_string("jogo", "idioma", global.idioma);
    ini_close();
}