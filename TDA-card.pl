:- module(TDA-card, [
    initEnergyCard/4,
    initPokemonCard/13,
    initTrainerCard/7
    
])



% =============================
% ========== TDA CARD =========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista con los siguientes elementos:

% tipoCarta -> string (atomo)
% Numero -> int
% Nombre -> string

% Además, dependiendo del tipo de carta:

% POKEMON TYPE:
% EvolucionDe -> string
% PS -> int+
% Tipo -> string
% Debilidad -> string
% Resistencia -> string
% CosteRetirada -> int
% EsEX -> Boolean
% habilidad -> Attack
% ataques -> List Attack

% TRAINER TYPE:
% Tipo -> string
% Texto -> string
% P -> predicado


% ======================================================
% =================== CONSTRUCTORES ====================
% ======================================================

initEnergyCard(Expansion, Numero, Nombre, EnergyCard) :-
  EnergyCard = [energy, Expansion, Numero, Nombre].

initPokemonCard(Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard) :-
  PokemonCard = [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques, PokemonCard].

initTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard) :-
  TrainerCard = [trainer, Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard].
