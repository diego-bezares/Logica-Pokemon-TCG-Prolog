
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
