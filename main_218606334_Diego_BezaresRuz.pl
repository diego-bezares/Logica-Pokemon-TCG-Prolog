
% ================== FUNCIONES AUXILIARES ==========================

% ===============================================
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
% ===============================================

% ===============================================
% validar_limite_copias/2: Valida que la cantidad de copias de una carta de tipo entrenador
% o pokemon se menor o igual a 4.
% Meta Primaria: validar_limite_copias(Mazo, CartasARevisar).

% Caso Base: CartasARevisar es vacio.
validar_limite_copias(_, []).

% Caso Recursivo 1: La Cabeza de CartasARevisar es una carta tipo energía.
validar_limite_copias(Mazo, [Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo == energy,
  validar_limite_copias(Mazo, Cola).

% Caso Recursivo 2: La Cabeza de CartasARevisar no es una carta tipo energía y su límite de copias
% es menor o igual a 4.
validar_limite_copias(Mazo, [Cabeza | Cola]):-
  getTypeCard(Cabeza, Tipo),
  Tipo \== energy,
  getNombreCard(Cabeza, NombreBuscado),
  contar_copias(NombreBuscado, Mazo, Copias),
  Copias =< 4,
  validar_limite_copias(Mazo, Cola).
% ===============================================

% ===============================================
% tiene_pokemon_basico/1: Valida si en una lista de cartas existe al menos una de tipo pokemon
% con el campo EvolucionDe vacio (null).
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
% ===============================================

% ===============================================
% randomPuro/2: Genera el siguiente número pseudoaleatorio según el enunciado.
% Meta Primaria: randomPuro(Xn, Xn1).

randomPuro(Xn, Xn1):- 
  Xn1 is (1103515245 * Xn + 12345) mod 2147483648.
% ===============================================

% ===============================================
% extraerCarta/4: Encuentra una carta por su índice, la extrae y devuelve la lista restante.
% Meta Primaria: extraer_carta(Indice, ListaOriginal, CartaExtraida, ListaRestante).

% Caso Base: El índice es 0, extraemos la cabeza y el resto es la cola.
extraerCarta(0, [Cabeza | Cola], Cabeza, Cola).

% Caso Recursivo: El índice es mayor a 0, avanzamos en la cola restando 1 al índice.
extraerCarta(Index, [Cabeza | Cola], Elemento, [Cabeza | RestoCola]) :-
    Index > 0,
    NextIndex is Index - 1,
    extraerCarta(NextIndex, Cola, Elemento, RestoCola).
% ===============================================

% ===============================================
% extraer_n_cartas/4: Extrae N cartas de la parte superior del mazo y devuelve el resto.
% Meta Primaria: extraer_n_cartas(N, MazoOriginal, CartasExtraidas, MazoRestante).

% Caso Base: Extraer 0 cartas deja la lista vacía y el mazo intacto.
extraer_n_cartas(0, Mazo, [], Mazo).

% Caso Recursivo: Extraer 1 carta de la cabeza, restar N, y seguir extrayendo.
extraer_n_cartas(N, [Cabeza | Cola], [Cabeza | RestoExtraidas], MazoRestante) :-
    N > 0,
    N2 is N - 1,
    extraer_n_cartas(N2, Cola, RestoExtraidas, MazoRestante).
% ===============================================

% ===============================================
% prepararJugador/6: 
% Meta Primaria: prepararJugador(MazoOriginal, Semilla, ManoFinal, PremiosFinales, MazoSobrante, NuevaSemilla).

prepararJugador(MazoOriginal, Semilla, ManoFinal, PremiosFinales, MazoSobrante, NuevaSemilla):-
  
% ===============================================
  



% ================== REQUERIMIENTOS FUNCIONALES ====================

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
% Meta Secundaria: Unificar la variable PokemonCard con la lista [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques] a través de uno de los constructores del tda-card.
% ==================================================================
createPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard) :-
  initPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard).

% ==================================================================
% RF05: createTrainerCard/7
% Meta Primaria: createTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard).
% Meta Secundaria: Unificar la variable TrainerCard con la lista [trainer, Expansion, Numero, Nombre, Tipo, Texto, P] a través de uno de los constructores del tda-card.
% ==================================================================
createTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard) :-
  initTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard).

% ==================================================================
% RF06: createDeck/2
% Meta Primaria: createDeck(Cards, Deck).
% Meta Secundaria: Unificar la variable Deck con Cards solo si Cards tiene un pokemon básico, no tiene ninguna carta que no sea de tipo energy con más de 4 copias y su largo es igual a 60.
% ==================================================================
createDeck(Cards, Deck):-
  length(Cards, 60),
  validar_limite_copias(Cards, Cards),
  tiene_pokemon_basico(Cards),
  Deck = Cards.

% ==================================================================
% RF07: shuffleDeck/3
% Meta Primaria: shuffleDeck(DeckIn, Seed, DeckOut).
% Meta Secundaria: Generar índice aleatorio, extraer carta, barajar el resto.
% ======================================================================
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

% ==================================================================
% RF08: initGame/4
% Meta Primaria: initGame(Deck1, Deck2, Seed, Game).
% Meta Secundaria: 
% ======================================================================
  
  
  







