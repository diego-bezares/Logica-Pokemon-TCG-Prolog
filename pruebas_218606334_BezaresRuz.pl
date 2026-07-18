:- use_module('main_218606334_Diego_BezaresRuz.pl').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PREDICADOS DE APOYO PARA ATAQUES Y ENTRENADORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Sin Efecto: El ataque solo hace daño, no altera el estado del juego extra.
sinEfecto(JuegoIn, JuegoOut) :-
    JuegoOut = JuegoIn.

% 2. Efecto Hau: Robar 3 cartas.
% Demostración de cómo tu arquitectura resuelve un efecto complejo en 4 líneas.
efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 1,
    robar_carta_jugador(J1, _, J1_A),
    robar_carta_jugador(J1_A, _, J1_B),
    robar_carta_jugador(J1_B, _, J1_Final),
    JuegoOut = [J1_Final, J2, Turno].

efectoHau([J1, J2, Turno], JuegoOut) :-
    Turno == 2,
    robar_carta_jugador(J2, _, J2_A),
    robar_carta_jugador(J2_A, _, J2_B),
    robar_carta_jugador(J2_B, _, J2_Final),
    JuegoOut = [J1, J2_Final, Turno].

% 3. Efecto Poción: Cura 30 de daño al activo (Lógica base implementada).
efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 1,
    J1 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo \== null,
    getDano(PokeActivo, DanoActual),
    NuevoDano is max(0, DanoActual - 30),
    PokeActivo = [Id, CartaBase, Asociadas, Energias, _, Estado],
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    NuevoJ1 = [Mazo, Mano, ActivoCurado, Banca, Descarte, Premios],
    JuegoOut = [NuevoJ1, J2, Turno].

efectoPotion([J1, J2, Turno], JuegoOut) :-
    Turno == 2,
    J2 = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios],
    PokeActivo \== null,
    getDano(PokeActivo, DanoActual),
    NuevoDano is max(0, DanoActual - 30),
    PokeActivo = [Id, CartaBase, Asociadas, Energias, _, Estado],
    ActivoCurado = [Id, CartaBase, Asociadas, Energias, NuevoDano, Estado],
    NuevoJ2 = [Mazo, Mano, ActivoCurado, Banca, Descarte, Premios],
    JuegoOut = [J1, NuevoJ2, Turno].

% ==================================================================
% ==================================================================
efectoParalizar(JuegoIn, JuegoIn).
efectoGreatBall(JuegoIn, JuegoIn).
efectoCynthia(JuegoIn, JuegoIn).
efectoPokemonFanClub(JuegoIn, JuegoIn).
efectoProfessorKukui(JuegoIn, JuegoIn).
efectoSwitch(JuegoIn, JuegoIn).
efectoPokemonCatcher(JuegoIn, JuegoIn).



    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ENERGIA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

createEnergyCard(
    "Energia Basica",
    4,
    "Rayo",
    EnergiaRayo
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ATAQUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Pikachu (Crimson Invasion 30)

createAttack(
    [[1,"Rayo"]],
    "Impactrueno",
    "",
    20,
    sinEfecto,
    A_Impactrueno
).

createAttack(
    [[2,"Rayo"],[1,"Incolora"]],
    "Bola Voltio",
    "",
    50,
    sinEfecto,
    A_BolaVoltio
).

%% Pikachu (Shining Legends 28)

createAttack(
    [[1,"Incolora"]],
    "Placaje",
    "",
    10,
    sinEfecto,
    A_Placaje
).

createAttack(
    [[2,"Rayo"],[1,"Incolora"]],
    "Impactrueno",
    "",
    50,
    sinEfecto,
    A_Impactrueno50
).

%% Alolan Raichu

createAttack(
    [[1,"Rayo"]],
    "Psíquico",
    "",
    20,
    sinEfecto,
    A_Psiquico
).

createAttack(
    [[3,"Rayo"]],
    "Rayo",
    "",
    80,
    sinEfecto,
    A_Rayo80
).

%% Voltorb

createAttack(
    [[1,"Rayo"]],
    "Bola Relámpago",
    "",
    10,
    sinEfecto,
    A_BolaRelampago10
).

%% Electrode

createAttack(
    [[1,"Rayo"]],
    "Bola Relámpago",
    "",
    60,
    sinEfecto,
    A_BolaRelampago60
).

%% Electabuzz

createAttack(
    [[1,"Rayo"]],
    "Puño Trueno",
    "",
    30,
    sinEfecto,
    A_PunoTrueno
).

%% Electivire

createAttack(
    [[2,"Rayo"]],
    "Electrocañón",
    "",
    50,
    sinEfecto,
    A_Electrocanon
).

createAttack(
    [[4,"Rayo"]],
    "Voltio Salvaje",
    "",
    120,
    sinEfecto,
    A_VoltioSalvaje
).

%% Blitzle

createAttack(
    [[1,"Incolora"]],
    "Cornada",
    "",
    10,
    sinEfecto,
    A_Cornada
).

%% Zebstrika

createAttack(
    [[2,"Rayo"]],
    "Patada Salvaje",
    "",
    40,
    sinEfecto,
    A_PatadaSalvaje
).

%% Pidgey

createAttack(
    [[1,"Incolora"]],
    "Ataque Ala",
    "",
    20,
    sinEfecto,
    A_AtaqueAla20
).

%% Pidgeotto

createAttack(
    [[2,"Incolora"]],
    "Ataque Ala",
    "",
    40,
    sinEfecto,
    A_AtaqueAla40
).

%% Raikou

createAttack(
    [[2,"Rayo"]],
    "Impacto Trueno",
    "",
    30,
    sinEfecto,
    A_ImpactoTrueno
).

createAttack(
    [[3,"Rayo"]],
    "Colmillo Trueno",
    "Lanza una moneda. Si sale cara, el Pokémon Activo de tu rival pasa a estar Paralizado.",
    60,
    efectoParalizar,
    A_ColmilloTrueno
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% POKEMON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

createPokemonCard(
    "Crimson Invasion",
    30,
    "Pikachu",
    null,
    70,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_Impactrueno,A_BolaVoltio],
    Pikachu1
).

createPokemonCard(
    "Shining Legends",
    28,
    "Pikachu",
    null,
    60,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_Placaje,A_Impactrueno50],
    Pikachu2
).

createPokemonCard(
    "Crimson Invasion",
    31,
    "Alolan Raichu",
    "Pikachu",
    110,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_Psiquico,A_Rayo80],
    Raichu
).

createPokemonCard(
    "Shining Legends",
    30,
    "Voltorb",
    null,
    60,
    "Rayo",
    "Lucha",
    null,
    1,
    false,
    null,
    [A_BolaRelampago10],
    Voltorb
).

createPokemonCard(
    "Shining Legends",
    31,
    "Electrode",
    "Voltorb",
    90,
    "Rayo",
    "Lucha",
    null,
    1,
    false,
    null,
    [A_BolaRelampago60],
    Electrode
).

createPokemonCard(
    "Ultra Prism",
    43,
    "Electabuzz",
    null,
    80,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_PunoTrueno],
    Electabuzz
).

createPokemonCard(
    "Burning Shadows",
    43,
    "Electivire",
    "Electabuzz",
    140,
    "Rayo",
    "Lucha",
    "Metal",
    3,
    false,
    null,
    [A_Electrocanon,A_VoltioSalvaje],
    Electivire
).

createPokemonCard(
    "Lost Thunder",
    81,
    "Blitzle",
    null,
    60,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_Cornada],
    Blitzle
).

createPokemonCard(
    "Lost Thunder",
    82,
    "Zebstrika",
    "Blitzle",
    110,
    "Rayo",
    "Lucha",
    "Metal",
    1,
    false,
    null,
    [A_PatadaSalvaje],
    Zebstrika
).

createPokemonCard(
    "Team Up",
    121,
    "Pidgey",
    null,
    60,
    "Incolora",
    "Rayo",
    "Lucha",
    1,
    false,
    null,
    [A_AtaqueAla20],
    Pidgey
).

createPokemonCard(
    "Team Up",
    123,
    "Pidgeotto",
    "Pidgey",
    80,
    "Incolora",
    "Rayo",
    "Lucha",
    1,
    false,
    null,
    [A_AtaqueAla40],
    Pidgeotto
).

createPokemonCard(
    "Shining Legends",
    32,
    "Raikou",
    null,
    120,
    "Rayo",
    "Lucha",
    "Metal",
    2,
    false,
    null,
    [A_ImpactoTrueno,A_ColmilloTrueno],
    Raikou
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ENTRENADORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

createTrainerCard(
    "Ultra Prism",
    119,
    "Cynthia",
    "partidario",
    "Baraja tu mano en tu mazo. Luego roba 6 cartas.",
    efectoCynthia,
    Cynthia
).

createTrainerCard(
    "Sun & Moon",
    119,
    "Gran Ball",
    "objeto",
    "Mira las 7 primeras cartas de tu mazo...",
    efectoGreatBall,
    GreatBall
).

createTrainerCard(
    "Celestial Storm",
    132,
    "Hau",
    "partidario",
    "Roba 3 cartas.",
    efectoHau,
    Hau
).

createTrainerCard(
    "Sun & Moon",
    126,
    "Pokémon Catcher",
    "objeto",
    "Cambia el Pokémon Activo de tu rival.",
    efectoPokemonCatcher,
    PokemonCatcher
).

createTrainerCard(
    "Ultra Prism",
    133,
    "Club de Fans Pokémon",
    "partidario",
    "Busca 2 Pokémon Básicos.",
    efectoPokemonFanClub,
    PokemonFanClub
).

createTrainerCard(
    "Sun & Moon",
    127,
    "Poción",
    "objeto",
    "Cura 30 puntos de daño.",
    efectoPotion,
    Potion
).

createTrainerCard(
    "Sun & Moon",
    128,
    "Profesor Kukui",
    "partidario",
    "Roba 2 cartas.",
    efectoProfessorKukui,
    ProfessorKukui
).

createTrainerCard(
    "Celestial Storm",
    147,
    "Cambio",
    "objeto",
    "Cambia tu Pokémon Activo.",
    efectoSwitch,
    Switch
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAZO OFICIAL LETS PLAY PIKACHU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

createDeck(
[
Pikachu1,Pikachu1,
Pikachu2,Pikachu2,
Raichu,Raichu,
Electrode,Electrode,
Voltorb,Voltorb,Voltorb,
Electivire,Electivire,
Electabuzz,Electabuzz,Electabuzz,
Zebstrika,
Blitzle,Blitzle,
Pidgeotto,
Pidgey,Pidgey,
Raikou,Raikou,

Cynthia,
GreatBall,GreatBall,
Hau,Hau,Hau,Hau,
PokemonCatcher,
PokemonFanClub,PokemonFanClub,
Potion,
ProfessorKukui,
Switch,Switch,

EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo
],
Deck1
).

createDeck(
[
Pikachu1,Pikachu1,
Pikachu2,Pikachu2,
Raichu,Raichu,
Electrode,Electrode,
Voltorb,Voltorb,Voltorb,
Electivire,Electivire,
Electabuzz,Electabuzz,Electabuzz,
Zebstrika,
Blitzle,Blitzle,
Pidgeotto,
Pidgey,Pidgey,
Raikou,Raikou,

Cynthia,
GreatBall,GreatBall,
Hau,Hau,Hau,Hau,
PokemonCatcher,
PokemonFanClub,PokemonFanClub,
Potion,
ProfessorKukui,
Switch,Switch,

EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo,EnergiaRayo,EnergiaRayo,
EnergiaRayo,EnergiaRayo
],
Deck2
).


% ======================================================================
% INICIO DE SIMULACIÓN DE PRUEBAS
% Archivo: pruebas_218606334_BezaresRuz.pl
% ======================================================================

% 1. Inicialización del Tablero
shuffleDeck(Deck1, 12345, Deck1Barajado),
shuffleDeck(Deck2, 54321, Deck2Barajado),
initGame(Deck1Barajado, Deck2Barajado, 82453, J_Init),
printGame(J_Init, StrInit), write(StrInit),

% 2. El Setup del Jugador 1
% Asumiendo que el Jugador 1 tiene a "Pikachu1" en la mano.
% Usamos tu predicado para bajarlo a la banca:
playToBench(J_Init, Pikachu1, J_T0_A),
% En tu lógica, las cartas bajan como CartaEnJuego con ID [Nombre, IndexBanca].
% Como es la primera carta, su ID será ["Pikachu", 0].
% Lo subimos a Activo:
changeActivePokemon(J_T0_A, ["Pikachu", 0], J_T0_B),
% Terminamos su fase inicial (simulando un "pasar turno")
usePokemonAttack(J_T0_B, _, null, _, J_T1_Start),

% 3. El Setup del Jugador 2
% Asumiendo que el Jugador 2 tiene a "Voltorb" en la mano.
playToBench(J_T1_Start, Voltorb, J_T1_A),
changeActivePokemon(J_T1_A, ["Voltorb", 0], J_T1_B),
usePokemonAttack(J_T1_B, _, null, _, J_T2_Start),

% 4. El Combate Real (El Inicio de la Matanza)
% Turno del Jugador 1. Extrae una carta (suponiendo que saca un Raichu).
drawCardFromDeck(J_T2_Start, Raichu, J_T2_A),

% Le asocia la energía eléctrica a su activo (Pikachu).
useEnergyCard(J_T2_A, EnergiaRayo, ["Pikachu", 0], J_T2_B),

% El Jugador 1 ataca con "Impactrueno". 
% Observa cómo pasamos la CartaEnJuego completa ("Pikachu", 0).
usePokemonAttack(J_T2_B, ["Pikachu", 0], "Impactrueno", [], J_T3_Start),

% Imprimir el estado del juego para ver el daño reflejado en Voltorb.
printGame(J_T3_Start, Str_T3), write(Str_T3),

% 5. La Respuesta del Jugador 2
% Saca un Hau
drawCardFromDeck(J_T3_Start, Hau, J_T3_A),

% Juega un entrenador (Hau)
useTrainerCard(J_T3_A, Hau, [], J_T3_B),

% Voltorb ataca de vuelta
usePokemonAttack(J_T3_B, ["Voltorb", 0], "Bola Relámpago", [], J_T4_Start),

printGame(J_T4_Start, Str_T4), write(Str_T4),

% 6. El Remate (El Knockout)
% Turno del Jugador 1. Pikachu vuelve a usar "Impactrueno" para liquidar a Voltorb.
% Esto debería disparar tu regla verificar_knockout y mandar a Voltorb al descarte.
usePokemonAttack(J_T4_Start, ["Pikachu", 0], "Impactrueno", [], J_T5_Start),

% Imprimimos el estado final. Si tu lógica es perfecta, el Activo del Jugador 2 
% dirá "null", y su descarte contendrá al Voltorb derrotado y sus energías.
printGame(J_T5_Start, Str_T5), write(Str_T5).






