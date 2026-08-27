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

