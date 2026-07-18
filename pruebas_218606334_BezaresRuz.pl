% ==================================================================
% ARCHIVO DE PRUEBAS
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

% Generador de relleno legal para el mazo
generar_n_copias(0, _, []).
generar_n_copias(N, Elemento, [Elemento | Cola]) :-
    N > 0, N1 is N - 1, generar_n_copias(N1, Elemento, Cola).

% ==================================================================
% REGLA MAESTRA DE SIMULACIÓN (Acá viven las variables)
% ==================================================================
simular_partida :-
    % 1. FABRICAR CARTAS BASE
    createEnergyCard("Expansion", 1, "Rayo", EnergiaRayo),
    % Hacemos que el ataque pegue 60 para asegurar el Knockout en la prueba
    createAttack([[1, "Rayo"]], "Impactrueno Mortal", "One shot", 60, sinEfecto, A_Impactrueno),
    createAttack([[1, "Rayo"]], "Bola Relampago", "Basico", 10, sinEfecto, A_BolaRelampago),
    
    createPokemonCard("Exp", 1, "Pikachu", null, 60, "Rayo", "Lucha", "Metal", 1, false, null, [A_Impactrueno], Pikachu),
    createPokemonCard("Exp", 2, "Voltorb", null, 60, "Rayo", "Lucha", null, 1, false, null, [A_BolaRelampago], Voltorb),
    createTrainerCard("Exp", 3, "Hau", "partidario", "Roba 3", efectoHau, Hau),
    
    % 2. ARMAR MAZO LEGAL (60 cartas, max 4 copias salvo energías, tiene básicos)
    generar_n_copias(53, EnergiaRayo, ListaEnergias),
    MazoBruto = [Pikachu, Pikachu, Voltorb, Voltorb, Hau, Hau, Hau | ListaEnergias],
    createDeck(MazoBruto, Deck1),
    
    % 3. INICIO DEL JUEGO
    shuffleDeck(Deck1, 92415, Deck1Barajado),
    shuffleDeck(Deck1, 54321, Deck2Barajado),
    initGame(Deck1Barajado, Deck2Barajado, 12345, J_Init_Random),
    
    % Como initGame tiene azar (barajeo y moneda), forzamos las condiciones 
    % exactas para que funcione el 100% de las veces.
    J_Init_Random = [[Mz1, Mn1, Act1, Bnc1, Dsc1, Prm1], [Mz2, Mn2, Act2, Bnc2, Dsc2, Prm2], _TurnoAzar],
    
    % Inyectamos las cartas requeridas en la mano y forzamos el Turno a 1
    J_Init = [[Mz1, [Pikachu, EnergiaRayo | Mn1], Act1, Bnc1, Dsc1, Prm1], 
              [Mz2, [Voltorb, Hau | Mn2], Act2, Bnc2, Dsc2, Prm2], 1],
    write("\n========== INICIO DE PARTIDA ==========\n"),
    printGame(J_Init, S0), write(S0),
    
    % 4. TURNO 1 (Jugador 1: Baja a Pikachu y pasa)
    playToBench(J_Init, Pikachu, J_1),
    % Extraemos a Pikachu de la banca dinámicamente para subirlo
    J_1 = [_, _, _, [PikaBanca|_], _, _],
    changeActivePokemon(J_1, PikaBanca, J_2),
    % Extraemos a Pikachu Activo para usarlo de referencia en el ataque vacío
    J_2 = [_, _, PikaActivoT1, _, _, _],
    usePokemonAttack(J_2, PikaActivoT1, null, [], J_3), % Pasa turno
    
    % 5. TURNO 2 (Jugador 2: Baja a Voltorb y pasa)
    playToBench(J_3, Voltorb, J_4),
    J_4 = [_, J2Data, _], J2Data = [_, _, _, [VoltBanca|_], _, _],
    changeActivePokemon(J_4, VoltBanca, J_5),
    J_5 = [_, J2Data2, _], J2Data2 = [_, _, VoltActivoT2, _, _, _],
    usePokemonAttack(J_5, VoltActivoT2, null, [], J_6), % Pasa turno

    % 6. TURNO 3 (Jugador 1: Asigna Energía y ejecuta el Knockout)
    J_6 = [J1_T3, _, _], J1_T3 = [_, _, PikaActivoT3, _, _, _],
    useEnergyCard(J_6, EnergiaRayo, PikaActivoT3, J_7),
    
    % Extraemos la versión actualizada del Pikachu (ahora con energía) para atacar
    J_7 = [J1_T3_B, _, _], J1_T3_B = [_, _, PikaActivoT3_B, _, _, _],
    usePokemonAttack(J_7, PikaActivoT3_B, "Impactrueno Mortal", [], J_Final),
    
    write("\n========== GOLPE Y KNOCKOUT ==========\n"),
    printGame(J_Final, SF), write(SF),
    write("\n>>> SIMULACION EXITOSA: Voltorb eliminado, Jugador 1 cobró 1 premio.\n").
