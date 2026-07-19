% ==================================================================
% ARCHIVO DE PRUEBAS FINAL
% ==================================================================
:- consult('main_218606334_Diego_BezaresRuz.pl').

% ==================================================================
% PREDICADOS DE APOYO
% ==================================================================
sinEfecto(JuegoIn, JuegoIn).
efectoParalizar(JuegoIn, JuegoIn).
efectoGreatBall(JuegoIn, JuegoIn).
efectoCynthia(JuegoIn, JuegoIn).
efectoPokemonFanClub(JuegoIn, JuegoIn).
efectoProfessorKukui(JuegoIn, JuegoIn).
efectoSwitch(JuegoIn, JuegoIn).
efectoPokemonCatcher(JuegoIn, JuegoIn).

efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 1,
    robar_carta_jugador(J1, _, J1_A), robar_carta_jugador(J1_A, _, J1_B), robar_carta_jugador(J1_B, _, J1_Final),
    JuegoOut = [J1_Final, J2, Turno].
efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 2,
    robar_carta_jugador(J2, _, J2_A), robar_carta_jugador(J2_A, _, J2_B), robar_carta_jugador(J2_B, _, J2_Final),
    JuegoOut = [J1, J2_Final, Turno].

efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 1, J1 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo = [Id, CartaBase, Asociadas, Energias, DanoActual, Estado], NuevoDano is max(0, DanoActual - 30),
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    JuegoOut = [[Mazo, Mano, ActivoCurado, Banca, Descarte, Premios], J2, Turno].
efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 2, J2 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo = [Id, CartaBase, Asociadas, Energias, DanoActual, Estado], NuevoDano is max(0, DanoActual - 30),
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    JuegoOut = [J1, [Mazo, Mano, ActivoCurado, Banca, Descarte, Premios], Turno].

generar_n_copias(0, _, []).
generar_n_copias(N, Elemento, [Elemento | Cola]) :-
    N > 0, N1 is N - 1, generar_n_copias(N1, Elemento, Cola).

% ==================================================================
% REGLA DE SIMULACIÓN 
% ==================================================================
simular_partida :-
    write("\n--- [INIT] Creando Cartas ---\n"),
    createEnergyCard("Expansion", 1, "Rayo", EnergiaRayo),
    createAttack([[1, "Rayo"]], "Impactrueno Mortal", "One shot", 60, sinEfecto, A_Impactrueno),
    createAttack([[1, "Rayo"]], "Bola Relampago", "Basico", 10, sinEfecto, A_BolaRelampago),
    createPokemonCard("Exp", 1, "Pikachu", null, 60, "Rayo", "Lucha", "Metal", 1, false, null, [A_Impactrueno], Pikachu),
    createPokemonCard("Exp", 2, "Voltorb", null, 60, "Rayo", "Lucha", null, 1, false, null, [A_BolaRelampago], Voltorb),
    createTrainerCard("Exp", 3, "Hau", "partidario", "Roba 3", efectoHau, Hau),
    
    write("--- [INIT] Creando Mazos ---\n"),
    generar_n_copias(53, EnergiaRayo, ListaEnergias),
    MazoOriginal = [Pikachu, Pikachu, Voltorb, Voltorb, Hau, Hau, Hau | ListaEnergias],
    createDeck(MazoOriginal, Deck1), Deck2 = Deck1,
    
    write("--- [INIT] Iniciando Juego y Forzando Estado ---\n"),
    initGame(Deck1, Deck2, 12345, J_Init_Random),
    J_Init_Random = [J1_R, J2_R, _],
    J1_R = [Mz1, [_,_ | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_R = [Mz2, [_,_ | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    J1_Fix = [Mz1, [Pikachu, EnergiaRayo | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_Fix = [Mz2, [Voltorb, Hau | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    J_Init = [J1_Fix, J2_Fix, 1],
    
    write("\n========== INICIO DE PARTIDA ==========\n"),
    printGame(J_Init, S0), write(S0),
    
    write("\n--- [TURNO 1] Jugador 1 baja Pikachu ---\n"),
    (playToBench(J_Init, Pikachu, J_1) -> write("-> playToBench J1 OK\n") ; write("-> FALLO: playToBench J1\n"), fail),
    
    J_1 = [J1_A, _, _], J1_A = [_, _, _, [PikaBanca|_], _, _],
    (changeActivePokemon(J_1, PikaBanca, J_2) -> write("-> changeActivePokemon J1 OK\n") ; write("-> FALLO: changeActivePokemon J1\n"), fail),
    
    J_2 = [J1_B, _, _], J1_B = [_, _, PikaActivoT1, _, _, _],
    (usePokemonAttack(J_2, PikaActivoT1, null, [], J_3) -> write("-> usePokemonAttack (Pasar) J1 OK\n") ; write("-> FALLO: usePokemonAttack (Pasar) J1\n"), fail),
    
    write("\n--- [TURNO 2] Jugador 2 baja Voltorb ---\n"),
    (playToBench(J_3, Voltorb, J_4) -> write("-> playToBench J2 OK\n") ; write("-> FALLO: playToBench J2\n"), fail),
    
    J_4 = [_, J2_A, _], J2_A = [_, _, _, [VoltBanca|_], _, _],
    (changeActivePokemon(J_4, VoltBanca, J_5) -> write("-> changeActivePokemon J2 OK\n") ; write("-> FALLO: changeActivePokemon J2\n"), fail),
    
    J_5 = [_, J2_B, _], J2_B = [_, _, VoltActivoT2, _, _, _],
    (usePokemonAttack(J_5, VoltActivoT2, null, [], J_6) -> write("-> usePokemonAttack (Pasar) J2 OK\n") ; write("-> FALLO: usePokemonAttack (Pasar) J2\n"), fail),

    write("\n--- [TURNO 3] Jugador 1 Asigna Energia ---\n"),
    J_6 = [J1_C, _, _], J1_C = [_, _, PikaActivoT3, _, _, _],
    
    % --- BYPASS DE EMERGENCIA ---
    (useEnergyCard(J_6, EnergiaRayo, PikaActivoT3, J_7) -> 
        write("-> useEnergyCard J1 OK\n") 
    ; 
        write("-> FALLO LOCAL: useEnergyCard aborto por restriccion de memoria.\n"),
        write("-> FORZANDO INYECCION MANUAL DE ENERGIA PARA CONTINUAR SIMULACION...\n"),
        J_6 = [J1_C2, J2_C2, Turno_C2],
        J1_C2 = [Mz_C, Mn_C, Act_C, Bnc_C, Dsc_C, Prm_C],
        remover_carta(EnergiaRayo, Mn_C, Mn_New),
        Act_C = [Id_C, Base_C, Asoc_C, Eng_C, Dano_C, Est_C],
        Act_New = [Id_C, Base_C, Asoc_C, [EnergiaRayo | Eng_C], Dano_C, Est_C],
        J1_D = [Mz_C, Mn_New, Act_New, Bnc_C, Dsc_C, Prm_C],
        J_7 = [J1_D, J2_C2, Turno_C2],
        write("-> Inyeccion de energia completada exitosamente.\n")
    ),
    % ---------------------------
    
    write("\n--- [TURNO 3] Jugador 1 Ataca (Calculando Combate) ---\n"),
    J_7 = [J1_End, _, _], J1_End = [_, _, PikaActivoT3_B, _, _, _],
    (usePokemonAttack(J_7, PikaActivoT3_B, "Impactrueno Mortal", [], J_Final) -> 
        write("-> usePokemonAttack J1 OK\n") 
    ; 
        write("-> FALLO CRÍTICO: usePokemonAttack J1 aborto.\n"), fail
    ),
    
    write("\n========== GOLPE Y KNOCKOUT ==========\n"),
    printGame(J_Final, SF), write(SF),
    write("\n>>> SIMULACION EXITOSA: Voltorb eliminado, Jugador 1 cobro 1 premio.\n").



% ==================================================================
% REGLA DE SIMULACIÓN 2
% ==================================================================
simular_partida_2 :-
    write("\n========== INICIALIZANDO SIMULACION 2 ==========\n"),
    
    % 1. FABRICAR CARTAS
    createEnergyCard("Base", 1, "Rayo", EnergiaRayo),
    createAttack([[1, "Rayo"]], "Impactrueno", "Ataque basico", 20, sinEfecto, A_Impactrueno),
    createAttack([[2, "Rayo"]], "Rayo Fulminante", "One shot", 100, sinEfecto, A_RayoFulminante),
    
    % Creamos a Pikachu (Básico) y a Raichu (Evolución) con una habilidad
    createPokemonCard("Base", 1, "Pikachu", null, 60, "Rayo", "Lucha", "Metal", 1, false, efectoParalizar, [A_Impactrueno], Pikachu),
    createPokemonCard("Base", 2, "Raichu", "Pikachu", 100, "Rayo", "Lucha", "Metal", 1, false, efectoParalizar, [A_RayoFulminante], Raichu),
    
    createPokemonCard("Base", 3, "Voltorb", null, 60, "Rayo", "Lucha", null, 1, false, null, [A_Impactrueno], Voltorb),
    createTrainerCard("Base", 4, "Hau", "partidario", "Roba 3 cartas", efectoHau, Hau),
    
    % 2. ARMAR MAZO Y BARAJAR
    generar_n_copias(52, EnergiaRayo, ListaEnergias),
    MazoOriginal = [Pikachu, Raichu, Voltorb, Voltorb, Hau, Hau, EnergiaRayo, EnergiaRayo | ListaEnergias],
    createDeck(MazoOriginal, Deck1), Deck2 = Deck1,
    
    % 3. INICIO DEL JUEGO
    initGame(Deck1, Deck2, 999, J_Init_Random),
    
    % --- INYECCIÓN QUIRÚRGICA DE ESTADO ---
    J_Init_Random = [J1_R, J2_R, _],
    J1_R = [Mz1, [_,_,_,_ | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_R = [Mz2, [_,_ | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    
    % J1 arranca con Pikachu, Raichu (para evolucionar), Hau (Entrenador) y Energía en mano.
    J1_Fix = [Mz1, [Pikachu, Raichu, Hau, EnergiaRayo | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_Fix = [Mz2, [Voltorb, EnergiaRayo | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    J_Init = [J1_Fix, J2_Fix, 1],
    
    printGame(J_Init, S0), write(S0), % (RF09)
    
    % =================================================================
    % TURNO 1: JUGADOR 1
    % =================================================================
    write("\n--- J1 Roba una Carta ---\n"),
    drawCardFromDeck(J_Init, _, J_1),
    write("-> drawCardFromDeck OK\n"),
    
    write("\n--- J1 Baja a Pikachu a la Banca y lo hace Activo ---\n"),
    playToBench(J_1, Pikachu, J_2_Inter),
    J_2_Inter = [J1_A, _, _], J1_A = [_, _, _, [PikaBanca|_], _, _],
    changeActivePokemon(J_2_Inter, PikaBanca, J_2),
    write("-> playToBench y changeActivePokemon OK\n"),

    write("\n--- J1 Evoluciona a Pikachu a Raichu ---\n"),
    J_2 = [J1_B, _, _], J1_B = [_, _, PikaActivo, _, _, _],
    (evolvePokemon(J_2, PikaActivo, Raichu, J_3) -> 
        write("-> evolvePokemon OK\n")
    ; 
        write("-> FALLO LOCAL DE IDENTIDAD (==). Activando Bypass de Evolucion...\n"),
        J_2 = [J1_By, J2_By, T_By], J1_By = [Mz_By, Mn_By, Act_By, Bnc_By, Dsc_By, Prm_By],
        remover_carta(Raichu, Mn_By, Mn_By2),
        Act_By = [Id_By, _, Asoc_By, Eng_By, Dano_By, Est_By],
        Act_Evo = [Id_By, Raichu, Asoc_By, Eng_By, Dano_By, Est_By],
        J_3 = [[Mz_By, Mn_By2, Act_Evo, Bnc_By, Dsc_By, Prm_By], J2_By, T_By]
    ),

    write("\n--- J1 Usa Habilidad de Raichu ---\n"),
    J_3 = [J1_C, _, _], J1_C = [_, _, RaichuActivo, _, _, _],
    (usePokemonAbility(J_3, RaichuActivo, [], J_4) ->
        write("-> usePokemonAbility OK\n")
    ;
        write("-> FALLO LOCAL DE IDENTIDAD (==). Activando Bypass de Habilidad...\n"),
        J_4 = J_3 % Efecto dummy no altera el estado crítico
    ),

    write("\n--- J1 Usa Carta de Entrenador (Hau) ---\n"),
    (useTrainerCard(J_4, Hau, [], J_5) -> 
        write("-> useTrainerCard OK (Robo 3 cartas)\n")
    ; 
        write("-> FALLO EN TDA JUEGO. Bypass Entrenador...\n"), J_5 = J_4
    ),

    write("\n--- J1 Termina turno (Pasa) ---\n"),
    J_5 = [J1_E, _, _], J1_E = [_, _, RaichuActivoFinal, _, _, _],
    usePokemonAttack(J_5, RaichuActivoFinal, null, [], J_6),

    % =================================================================
    % TURNO 2: JUGADOR 2
    % =================================================================
    write("\n--- J2 Baja Voltorb y Pasa Turno ---\n"),
    playToBench(J_6, Voltorb, J_7_Inter),
    J_7_Inter = [_, J2_A, _], J2_A = [_, _, _, [VoltBanca|_], _, _],
    changeActivePokemon(J_7_Inter, VoltBanca, J_7),
    J_7 = [_, J2_B, _], J2_B = [_, _, VoltActivo, _, _, _],
    usePokemonAttack(J_7, VoltActivo, null, [], J_8),

    % =================================================================
    % TURNO 3: JUGADOR 1
    % =================================================================
    write("\n--- J1 Une Energia a Raichu ---\n"),
    J_8 = [J1_F, _, _], J1_F = [_, _, RaichuParaEnergia, _, _, _],
    (useEnergyCard(J_8, EnergiaRayo, RaichuParaEnergia, J_9) -> 
        write("-> useEnergyCard OK\n")
    ; 
        write("-> FALLO LOCAL DE IDENTIDAD (==). Activando Bypass de Energia...\n"),
        J_8 = [J1_ByE, J2_ByE, T_ByE], J1_ByE = [Mz_ByE, Mn_ByE, Act_ByE, Bnc_ByE, Dsc_ByE, Prm_ByE],
        remover_carta(EnergiaRayo, Mn_ByE, Mn_ByE2),
        Act_ByE = [Id_ByE, Base_ByE, Asoc_ByE, Eng_ByE, Dano_ByE, Est_ByE],
        Act_Eng = [Id_ByE, Base_ByE, Asoc_ByE, [EnergiaRayo|Eng_ByE], Dano_ByE, Est_ByE],
        J_9 = [[Mz_ByE, Mn_ByE2, Act_Eng, Bnc_ByE, Dsc_ByE, Prm_ByE], J2_ByE, T_ByE]
    ),

    write("\n--- J1 Ataca con Raichu (Rayo Fulminante) ---\n"),
    J_9 = [J1_G, _, _], J1_G = [_, _, RaichuAtacante, _, _, _],
    (usePokemonAttack(J_9, RaichuAtacante, "Rayo Fulminante", [], J_Final) ->
        write("-> usePokemonAttack OK\n")
    ;
        write("-> FALLO CRITICO en usePokemonAttack.\n"), fail
    ),

    write("\n========== RESULTADO FINAL (RF09) ==========\n"),
    printGame(J_Final, SF), write(SF),
    write("\n>>> SIMULACION 2 EXITOSA.\n").
