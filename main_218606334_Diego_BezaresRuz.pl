% ==================================================================
% ================== FUNCIONES AUXILIARES ==========================
% ==================================================================

% ==================================================================
% contar_copias/3: Cuenta cuantas cartas hay en una lista con el mismo nombre.
% Meta Primaria: contar_copias(NombreBuscado, ListaCartas, Cantidad).

% Caso Base: ListaCartas es vacía.
contar_copias(_, [], 0).

% Caso Recursivo 1: El nombre coincide.
contar_copias(NombreBuscado, [Cabeza | Cola], Cantidad):-
  getNombreCard(Cabeza, Nombre),
  NombreBuscado == Nombre,
  contar_copias(NombreBuscado, Cola, CantidadCola),
  Cantidad is CantidadCola + 1.
  
% Caso Recursivo 2: El nombre no coincide.
contar_copias(NombreBuscado, [Cabeza | Cola], Cantidad):-
  getNombreCard(Cabeza, Nombre),
  NombreBuscado \== Nombre,
  contar_copias(NombreBuscado, Cola, Cantidad).
% ==================================================================

% ==================================================================
% validar_limite_copias/2: Valida que la cantidad de copias de una carta de tipo entrenador
%                          o pokemon se menor o igual a 4.
% Meta Primaria: validar_limite_copias(Mazo, CartasARevisar).

% Caso Base: CartasARevisar es vacio.
validar_limite_copias(_, []).

% Caso Recursivo 1: La Cabeza de CartasARevisar es una carta tipo energía.
validar_limite_copias(Mazo, [Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo == energy,
  validar_limite_copias(Mazo, Cola).

% Caso Recursivo 2: La Cabeza de CartasARevisar no es una carta tipo energía y su límite de copias
%                   es menor o igual a 4.
validar_limite_copias(Mazo, [Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo \== energy,
  getNombreCard(Cabeza, NombreBuscado),
  contar_copias(NombreBuscado, Mazo, Copias),
  Copias =< 4,
  validar_limite_copias(Mazo, Cola).
% ==================================================================

% ==================================================================
% tiene_pokemon_basico/1: Valida si en una lista de cartas existe al menos una de tipo pokemon
%                         con el campo EvolucionDe vacio (null).
% Meta Primaria: tiene_pokemon_basico(ListaCartas).

% Caso Base Positivo: La cabeza de la lista es un pokemon y básico.
tiene_pokemon_basico([Cabeza | _]):-
  getTypeCard(Cabeza, Tipo),
  Tipo == pokemon,
  getEvolucionDePoke(Cabeza, EvolucionDe),
  EvolucionDe == null.

% Caso Recursivo 1: La cabeza de la lista no es un pokemon, se sigue buscando.
tiene_pokemon_basico([Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo \== pokemon,
  tiene_pokemon_basico(Cola).

% Caso Recursivo 2: La cabeza de la lista es un pokemon, pero no básico, se sigue buscando.
tiene_pokemon_basico([Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo == pokemon,
  getEvolucionDePoke(Cabeza; EvolucionDe),
  EvoluionDe \== null,
  tiene_pokemon_basico(Cola).
% ==================================================================

% ==================================================================
% randomPuro/2: Genera el siguiente número pseudoaleatorio según el enunciado.
% Meta Primaria: randomPuro(Xn, Xn1).

randomPuro(Xn, Xn1):- 
  Xn1 is (1103515245 * Xn + 12345) mod 2147483648.
% ==================================================================

% ==================================================================
% extraerCarta/4: Encuentra una carta por su índice, la extrae y devuelve la lista restante.
% Meta Primaria: extraer_carta(Indice, ListaOriginal, CartaExtraida, ListaRestante).

% Caso Base: El índice es 0, extraemos la cabeza y el resto es la cola.
extraerCarta(0, [Cabeza | Cola], Cabeza, Cola).

% Caso Recursivo: El índice es mayor a 0, avanzamos en la cola restando 1 al índice.
extraerCarta(Index, [Cabeza | Cola], Elemento, [Cabeza | RestoCola]) :-
    Index > 0,
    NextIndex is Index - 1,
    extraerCarta(NextIndex, Cola, Elemento, RestoCola).
% ==================================================================

% ==================================================================
% extraer_n_cartas/4: Extrae N cartas de la parte superior del mazo y devuelve el resto.
% Meta Primaria: extraer_n_cartas(N, MazoOriginal, CartasExtraidas, MazoRestante).

% Caso Base: Extraer 0 cartas deja la lista vacía y el mazo intacto.
extraer_n_cartas(0, Mazo, [], Mazo).

% Caso Recursivo: Extraer 1 carta de la cabeza, restar N, y seguir extrayendo.
extraer_n_cartas(N, [Cabeza | Cola], [Cabeza | RestoExtraidas], MazoRestante) :-
    N > 0,
    N2 is N - 1,
    extraer_n_cartas(N2, Cola, RestoExtraidas, MazoRestante).
% ==================================================================

% ==================================================================
% preparar_jugador/6: Baraja, extrae 7 cartas y 6 premios.
% Meta Primaria: preparar_jugador(MazoOriginal, SemillaIn, ManoFinal, PremiosFinales, MazoSobrante, SemillaOut).

% Caso 1: La mano de 7 cartas tiene un Pokémon básico.
preparar_jugador(MazoOriginal, SemillaIn, ManoFinal, PremiosFinales, MazoSobrante, SemillaOut) :-
    shuffleDeck(MazoOriginal, SemillaIn, MazoBarajado),
    extraer_n_cartas(7, MazoBarajado, ManoFinal, MazoIntermedio),
    tiene_pokemon_basico(ManoFinal),
    extraer_n_cartas(6, MazoIntermedio, PremiosFinales, MazoSobrante),
    randomPuro(SemillaIn, SemillaOut).

% Caso 2: La mano de 7 cartas no tiene básico.
preparar_jugador(MazoOriginal, SemillaIn, ManoFinal, PremiosFinales, MazoSobrante, SemillaOut) :-
    shuffleDeck(MazoOriginal, SemillaIn, MazoBarajado),
    extraer_n_cartas(7, MazoBarajado, ManoPosible, _),
    \+ tiene_pokemon_basico(ManoPosible),
    randomPuro(SemillaIn, NuevaSemilla),
    preparar_jugador(MazoOriginal, NuevaSemilla, ManoFinal, PremiosFinales, MazoSobrante, SemillaOut).
% ==================================================================

% ==================================================================
% remover_carta/3: Elimina un elemento de una lista y devuelve la lista sin el elemento.
% Meta Primaria: remover_carta(Elemento, Lista, ListaSinElemento).

remover_carta(Elemento, [Elemento | Cola], Cola).
remover_carta(Elemento, [Cabeza | Cola], [Cabeza | ColaRestante]) :-
    Elemento \== Cabeza,
    remover_carta(Elemento, Cola, ColaRestante).
% ==================================================================

% ==================================================================
% jugar_carta_banca/3: Hace las validaciones correspondientes para finalmente
%                      poner en juego una carta (TDA CARD) en la banca (TDA CARTAENJUEGO).
% Meta Primaria: jugar_carta_banca(JugadorIn, Carta, JugadorOut).

jugar_carta_banca([Mazo, Mano, PokeActivo, Banca, Descarte, Premios], Carta, JugadorOut):-
  % Se cargan todos los datos necesarios.
  getTypeCard(Carta, Tipo),
  getEvolucioDePoke(Carta, EvolucionDe),

  % Se hacen las validaciones.
  Tipo == pokemon,  % La carta a jugar es un pokemon.
  EvolucionDe == null,  % El pokemon es básico.
  length(Banca, L), L < 5, % Hay al menos un espacio en la banca.

  % Procesamiento.
  remover_carta(Carta, Mano, NuevaMano),
  % Se obtienen los datos necesarios para crear el TDA CartaEnJuego
  getNombreCard(Carta, Nombre),
  Id = [Nombre, L],
  initCartaEnJuego(Id, Carta, [], [], 0, normal, NuevaCartaEnJuego)

  % Se unifica todo en la variable JugadorOut.
  NuevaBanca = [NuevaCartaEnJuego | Banca],
  JugadorOut = [Mazo, NuevaMano, PokeActivo, NuevaBanca, Descarte, Premios].
% ==================================================================

% ==================================================================
% ejecutar_cambio_activo/3: Pone una carta en banca como pokemon activo.
% Meta Primaria: ejecutar_cambio_activo(JugadorIn, CartaEnBanca, JugadorOut).

% Regla 1: El campo PokeActivo es vacio.
ejecutar_cambio_activo([Mazo, Mano, PokeActivo, Banca, Descarte, Premios], CartaEnBanca, JugadorOut):-
  PokeActivo == null,
  member(CartaEnBanca, Banca),
  remover_carta(CartaEnBanca, Banca, NuevaBanca),
  JugadorOut = [Mazo, Mano, CartaEnBanca, NuevaBanca, Descarte, Premios].

% Regla 2: El campo PokeActivo no es vacio.
ejecutar_cambio_activo([Mazo, Mano, PokeActivo, Banca, Descarte, Premios], CartaEnBanca, JugadorOut):-
  PokeActivo \== null,
  member(CartaEnBanca, Banca),
  
  getCartaBase(PokeActivo, CartaBase),
  getCosteRetiradaPoke(CartaBase, CosteRetirada),
  getEnergias(PokeActivo, Energias),
  
  length(Energias, L), L >= CosteRetirada,
  extraer_n_cartas(CosteRetirada, Energias, EnergiasPagadas, EnergiasRestantes),
  append(EnergiasPagadas, Descarte, NuevoDescarte),

  getId(PokeActivo, Id),
  getCartasAsociadas(PokeActivo, CartasAsociadas),
  getDano(PokeActivo, Dano),
  getEstado(PokeActivo, Estado),

  PokeActivoActualizado = [Id, CartaBase, CartasAsociadas, EnergiasRestantes, Dano, Estado],

  remover_carta(CartaEnBanca, Banca, BancaIntermedia),
  NuevaBanca = [PokeActivoActualizado | BancaIntermedia],
  
  JugadorOut = [Mazo, Mano, CartaEnBanca, NuevaBanca, NuevoDescarte, Premios].
% ==================================================================

% ==================================================================
% robar_carta_jugador/3: Pone una carta del mazo en la mano del jugador.
% Meta Primaria: robar_carta_jugador(JugadorIn, CartaRobada, JugadorOut).

robar_carta_jugador([[CartaRobada | MazoRestante], Mano, PokeActivo, Banca, Descarte, Premios], CartaRobada, JugadorOut):-
  NuevaMano = [CartaRobada | Mano],
  JugadorOut = [MazoRestante, NuevaMano, PokeActivo, Banca, Descarte, Premios].
% ==================================================================

% ==================================================================
% unir_energia_jugador/4: Agrega una carta de energia a la lista de energias
%                         de una carta en juego dependiendo si es un pokemon activo
%                         o una carta en banca.
% Meta Primaria: unir_energia_jugador(JugadorIn, PokemonObjetivo, CartaEnergia, JugadorOut).

% Regla 1: El Pokemon Objetivo es el PokeActivo.
unir_energia_jugador([Mazo, Mano, PokeActivo, Banca, Descarte, Premios], PokemonObjetivo, CartaEnergia, JugadorOut):-
  PokeActivo \== null,
  PokeActivo == PokemonObjetivo,
  getTypeCard(CartaEnergia, Tipo),
  Tipo == energy,

  remover_carta(CartaEnergia, Mano, NuevaMano),

  getEnergias(PokeActivo, Energias),
  NuevasEnergias = [CartaEnergia | Energias],

  getId(PokeActivo, Id),
  getCartaBase(PokeActivo, CartaBase),
  getCartasAsociadas(PokeActivo, CartasAsociadas),
  getDano(PokeActivo, Dano),
  getEstado(PokeActivo, Estado),

  PokeActivoActualizado = [Id, CartaBase, CartasAsociadas, NuevasEnergias, Dano, Estado],
  JugadorOut = [Mazo, NuevaMano, PokeActivoActualizado, Banca, Descarte, Premios].

% Regla 2: El Pokemon Objetivo está en la banca.
unir_energia_jugador([Mazo, Mano, PokeActivo, Banca, Descarte, Premios], PokemonObjetivo, CartaEnergia, JugadorOut):-
  member(PokemonObjetivo, Banca),
  getTypeCard(CartaEnergia, Tipo),
  Tipo == energy,

  remover_carta(CartaEnergia, Mano, NuevaMano),
  remover_carta(PokemonObjetivo, Banca, BancaIntermedia),

  getEnergias(PokemonObjetivo, Energias),
  NuevasEnergias = [CartaEnergia | Energias],

  getId(PokemonObjetivo, Id),
  getCartaBase(PokemonObjetivo, CartaBase),
  getCartasAsociadas(PokemonObjetivo, CartasAsociadas),
  getDano(PokemonObjetivo, Dano),
  getEstado(PokemonObjetivo, Estado),

  PokeActualizado = [Id, CartaBase, CartasAsociadas, NuevasEnergias, Dano, Estado],
  NuevaBanca = [PokeActualizado | BancaIntermedia],
  JugadorOut = [Mazo, NuevaMano, PokeActivo, NuevaBanca, Descarte, Premios].
% ==================================================================




% ============================ O ===================================
  


% ==================================================================
% ================== REQUERIMIENTOS FUNCIONALES ====================
% ==================================================================

% ==================================================================
% RF02: createEnergyCard/4
% Meta Primaria: createEnergyCard(Expansion, Numero, Nombre, EnergyCard).
% Meta Secundaria: Unificar la variable EnergyCard con la lista [energy, Expansion, Numero, Nombre] a través de uno de los constructores del tda-card.
% ==================================================================
createEnergyCard(Expansion, Numero, Nombre, EnergyCard) :-
  initEnergyCard(Expansion, Numero, Nombre, EnergyCard).

% ==================================================================
% RF03: createAttack/5
% Meta Primaria: createAttack(Cost, Nombre, Descripcion, Dano, Predicado, Attack).
% Meta Secundaria: Unificar la variable Attack con la lista [Cost, Nombre, Descripcion, Dano, Predicado, Attack] a través del constructor del tda-attack.
% ==================================================================
createAttack(Cost, Nombre, Descripcion, Dano, Predicado, Attack) :-
  initAttack(Cost, Nombre, Descripcion, Dano, Predicado, Attack).

% ==================================================================
% RF04: createPokemonCard/13
% Meta Primaria: createPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard).
% Meta Secundaria: Unificar la variable PokemonCard con la lista [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques]
%                  a través de uno de los constructores del tda-card.
% ==================================================================
createPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard) :-
  initPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard).

% ==================================================================
% RF05: createTrainerCard/7
% Meta Primaria: createTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard).
% Meta Secundaria: Unificar la variable TrainerCard con la lista [trainer, Expansion, Numero, Nombre, Tipo, Texto, P] 
%                  a través de uno de los constructores del tda-card.
% ==================================================================
createTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard) :-
  initTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard).

% ==================================================================
% RF06: createDeck/2
% Meta Primaria: createDeck(Cards, Deck).
% Meta Secundaria: Unificar la variable Deck con Cards solo si Cards tiene un pokemon básico, 
%                  no tiene ninguna carta que no sea de tipo energy con más de 4 copias y su largo es igual a 60.
% ==================================================================
createDeck(Cards, Deck):-
  length(Cards, 60),
  validar_limite_copias(Cards, Cards),
  tiene_pokemon_basico(Cards),
  Deck = Cards.

% ===================================================================
% RF07: shuffleDeck/3
% Meta Primaria: shuffleDeck(DeckIn, Seed, DeckOut).
% Meta Secundaria: Generar índice aleatorio, extraer carta, barajar el resto.
% ===================================================================
% Caso Base: Mazo vacío.
shuffleDeck([], _, []).

% Caso Recursivo: Mazo con cartas.
shuffleDeck(DeckIn, Seed, DeckOut):-
    randomPuro(Seed, NuevaSemilla),
    length(DeckIn, Largo),
    Largo > 0,
    Index is NuevaSemilla mod Largo,
    extraerCarta(Index, DeckIn, CartaExtraida, DeckRestante),
    shuffleDeck(DeckRestante, NuevaSemilla, DeckOutRestante),
    DeckOut = [CartaExtraida | DeckOutRestante].

% ===================================================================
% RF08: initGame/4
% Meta Primaria: initGame(Deck1, Deck2, Seed, Game).
% Meta Secundaria: Preparar al jugador 1, preparar al jugador 2, generar 
%                  una semilla final para la moneda, calcular el turno inicial 
%                  y unificar todas las estructuras en el TDA Juego.
% ===================================================================
initGame(Deck1, Deck2, Seed, Game):-
  preparar_jugador(Deck1, Seed, Mano1, Premios1, MazoSobrante1, Seed2),
  preparar_jugador(Deck2, Seed2, Mano2, Premios2, MazoSobrante2, Seed3),
  randomPuro(Seed3, SeedMoneda),
  Turno is (SeedMoneda mod 2) + 1,
  J1 = [MazoSobrante1, Mano1, null, [], [], Premios1],
  J2 = [MazoSobrante2, Mano2, null, [], [], Premios2],
  Game = [J1, J2, Turno].

% ===================================================================
% RF09: printGame/
% Meta Primaria: 
% Meta Secundaria:
% ===================================================================


% ===================================================================
% RF10: playToBench/3
% Meta Primaria: playToBench(GameIn, Carta, GameOut).
% Meta Secundaria: Actualiza la banca del jugador 1 o jugador 2, dependiendo del
%                  turno actual y unifica el jugador actualizado en el TDA Juego.
% ===================================================================
% Es el turno del jugador 1.
playToBench([J1, J2, Turno], Carta, GameOut):-
  Turno == 1,
  jugar_carta_banca(J1, Carta, NuevoJ1),
  GameOut = [NuevoJ1, J2, Turno].

% Es el turno del jugador 2.
playToBench([J1, J2, Turno], Carta, GameOut):-
  Turno == 2,
  jugar_carta_banca(J2, Carta, NuevoJ2),
  GameOut = [J1, NuevoJ2, Turno].

% ===================================================================
% RF11: changeActivePokemon/3
% Meta Primaria: changeActivePokemon(GameIn, CartaBanca, GameOut).
% Meta Secundaria: Actualiza el pokemon activo del jugador 1 o jugador 2
%                  dependiendo del turno actual y unifica el jugador actualizado en el TDA Juego.
% ===================================================================
% Es el turno del jugador 1.
changeActivePokemon([J1, J2, Turno], CartaEnBanca, GameOut):-
  Turno == 1,
  ejecutar_cambio_activo(J1, CartaEnBanca, NuevoJ1),
  GameOut = [NuevoJ1, J2, Turno].

% Es el turno del jugador 2.
changeActivePokemon([J1, J2, Turno], CartaEnBanca, GameOut):-
  Turno == 2,
  ejecutar_cambio_activo(J2, CartaEnBanca, NuevoJ2),
  GameOut = [J1, NuevoJ2, Turno].

% ===================================================================
% RF12: drawCardFromDeck/3
% Meta Primaria: drawCardFromDeck(GameIn, CardObtained, GameOut).
% Meta Secundaria: Actualiza la mano del jugador 1 o jugador 2
%                  dependiendo del turno actual y unifica el jugador actualizado en el TDA Juego.
% ===================================================================
% Es el turno del jugador 1.
drawCardFromDeck([J1, J2, Turno], CardObtained, GameOut):-
  Turno == 1,
  robar_carta_jugador(J1, CardObtained, NuevoJ1),
  GameOut = [NuevoJ1, J2, Turno].

% Es el turno del jugador 2.
drawCardFromDeck([J1, J2, Turno], CardObtained, GameOut):-
  Turno == 2,
  robar_carta_jugador(J2, CardObtained, NuevoJ2),
  GameOut = [J1, NuevoJ2, Turno].

% ===================================================================
% RF13: useEnergyCard/4
% Meta Primaria: useEnergyCard(GameIn, CartaEnergia, PokemonObjetivo, GameOut).
% Meta Secundaria: Actualiza la energias de una carta en juego del jugador 1 o jugador 2
%                  dependiendo del turno actual y unifica el jugador actualizado en el TDA Juego.
% ===================================================================
% Es el turno del jugador 1.
useEnergyCard([J1, J2, Turno], CartaEnergia, PokemonObjetivo, GameOut):-
  Turno == 1,
  unir_energia_jugador(J1, CartaEnergia, PokemonObjetivo, NuevoJ1),
  GameOut = [NuevoJ1, J2, Turno].

% Es el turno del jugador 2.
useEnergyCard([J1, J2, Turno], CartaEnergia, PokemonObjetivo, GameOut):-
  Turno == 2,
  unir_energia_jugador(J2, CartaEnergia, PokemonObjetivo, NuevoJ2),
  GameOut = [J1, NuevoJ2, Turno].


