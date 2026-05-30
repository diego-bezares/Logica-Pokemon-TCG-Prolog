:- module(TDA-card, [
    
])


initEnergyCard(Expansion, Numero, Nombre, EnergyCard) :-
  EnergyCard = [energy, Expansion, Numero, Nombre].

initPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard) :-
  PokemonCard = [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard].


