:- module(TDA-card, [
    initEnergyCard/4,
    initPokemonCard/13,
    initTrainerCard/7
    
])



%
%
%

initEnergyCard(Expansion, Numero, Nombre, EnergyCard) :-
  EnergyCard = [energy, Expansion, Numero, Nombre].

initPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard) :-
  PokemonCard = [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard].

initTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard) :-
  TrainerCard = [trainer, Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard].
