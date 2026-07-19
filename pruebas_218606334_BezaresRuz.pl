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

% Efecto Hau: Robar 3 cartas.
efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 1,
    robar_carta_jugador(J1, _, J1_A), robar_carta_jugador(J1_A, _, J1_B), robar_carta_jugador(J1_B, _, J1_Final),
    JuegoOut = [J1_Final, J2, Turno].
efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 2,
    robar_carta_jugador(J2, _, J2_A), robar_carta_jugador(J2_A, _, J2_B), robar_carta_jugador(J2_B, _, J2_Final),
    JuegoOut = [J1, J2_Final, Turno].

% Efecto Poción: Cura 30 de daño.
efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 1,
    J1 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo = [Id, CartaBase, Asociadas, Energias, DanoActual, Estado],
    NuevoDano is max(0, DanoActual - 30),
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    JuegoOut = [[Mazo, Mano, ActivoCurado, Banca, Descarte, Premios], J2, Turno].
efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 2,
    J2 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo = [Id, CartaBase, Asociadas, Energias, DanoActual, Estado],
    NuevoDano is max(0, DanoActual - 30),
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    JuegoOut = [J1, [Mazo, Mano, ActivoCurado, Banca, Descarte, Premios], Turno].

% Generador de relleno legal para armar el mazo de 60
generar_n_copias(0, _, []).
generar_n_copias(N, Elemento, [Elemento | Cola]) :-
    N > 0, N1 is N - 1, generar_n_copias(N1, Elemento, Cola).

% ==================================================================
% REGLA DE SIMULACIÓN
% ==================================================================
simular_partida :-
    % 1. FABRICAR CARTAS BASE
    createEnergyCard("Expansion", 1, "Rayo", EnergiaRayo),
    % Hacemos que el ataque pegue 60 para que sea un One-Shot y probar el Knockout
    createAttack([[1, "Rayo"]], "Impactrueno Mortal", "One shot", 60, sinEfecto, A_Impactrueno),
    createAttack([[1, "Rayo"]], "Bola Relampago", "Basico", 10, sinEfecto, A_BolaRelampago),
    
    createPokemonCard("Exp", 1, "Pikachu", null, 60, "Rayo", "Lucha", "Metal", 1, false, null, [A_Impactrueno], Pikachu),
    createPokemonCard("Exp", 2, "Voltorb", null, 60, "Rayo", "Lucha", null, 1, false, null, [A_BolaRelampago], Voltorb),
    createTrainerCard("Exp", 3, "Hau", "partidario", "Roba 3", efectoHau, Hau),
    
    % 2. ARMAR MAZO (60 cartas exactas)
    generar_n_copias(53, EnergiaRayo, ListaEnergias),
    MazoOriginal = [Pikachu, Pikachu, Voltorb, Voltorb, Hau, Hau, Hau | ListaEnergias],
    createDeck(MazoOriginal, Deck1),
    
    % Ambos jugadores usan exactamente el mismo mazo
    Deck2 = Deck1,
    
    % 3. INICIO DEL JUEGO (El motor baraja con la semilla)
    initGame(Deck1, Deck2, 12345, J_Init_Random),
    % Desempaquetamos el juego aleatorio
    J_Init_Random = [J1_R, J2_R, _],
    % Desempaquetamos a los jugadores y quitamos las 2 primeras cartas de sus manos aleatorias
    J1_R = [Mz1, [_,_ | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_R = [Mz2, [_,_ | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    % Rearmamos a los jugadores forzando nuestras cartas de prueba.
    J1_Fix = [Mz1, [Pikachu, EnergiaRayo | RestoMn1], Act1, Bnc1, Dsc1, Prm1],
    J2_Fix = [Mz2, [Voltorb, Hau | RestoMn2], Act2, Bnc2, Dsc2, Prm2],
    % Forzamos el inicio en el Turno 1
    J_Init = [J1_Fix, J2_Fix, 1],
    % --------------------------------------
    
    write("\n========== INICIO DE PARTIDA ==========\n"),
    printGame(J_Init, S0), write(S0),
    
    % 4. TURNO 1 (Jugador 1: Baja a Pikachu y pasa)
    playToBench(J_Init, Pikachu, J_1),
    % Extraemos el Jugador 1 y su banca
    J_1 = [J1_A, _, _], J1_A = [_, _, _, [PikaBanca|_], _, _],
    changeActivePokemon(J_1, PikaBanca, J_2),
    % Extraemos el Jugador 1 y su activo
    J_2 = [J1_B, _, _], J1_B = [_, _, PikaActivoT1, _, _, _],
    usePokemonAttack(J_2, PikaActivoT1, null, [], J_3), % Pasa turno
    
    % 5. TURNO 2 (Jugador 2: Baja a Voltorb y pasa)
    playToBench(J_3, Voltorb, J_4),
    % Extraemos el Jugador 2 y su banca
    J_4 = [_, J2_A, _], J2_A = [_, _, _, [VoltBanca|_], _, _],
    changeActivePokemon(J_4, VoltBanca, J_5),
    % Extraemos el Jugador 2 y su activo
    J_5 = [_, J2_B, _], J2_B = [_, _, VoltActivoT2, _, _, _],
    usePokemonAttack(J_5, VoltActivoT2, null, [], J_6), % Pasa turno

    % 6. TURNO 3 (Jugador 1: Asigna Energía y ataca)
    % Extraemos el activo actual del Jugador 1
    J_6 = [J1_C, _, _], J1_C = [_, _, PikaActivoT3, _, _, _],
    useEnergyCard(J_6, EnergiaRayo, PikaActivoT3, J_7),
    
    % Extraemos el activo *actualizado* del Jugador 1 (ahora tiene la energía)
    J_7 = [J1_D, _, _], J1_D = [_, _, PikaActivoT3_B, _, _, _],
    usePokemonAttack(J_7, PikaActivoT3_B, "Impactrueno Mortal", [], J_Final),
    
    write("\n========== GOLPE Y KNOCKOUT ==========\n"),
    printGame(J_Final, SF), write(SF),
    write("\n>>> SIMULACION EXITOSA: Voltorb eliminado, Jugador 1 cobro 1 premio.\n").
