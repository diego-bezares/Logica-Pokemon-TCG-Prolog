:- module(tda_card, [
    initEnergyCard/4,
    initPokemonCard/13,
    initTrainerCard/7,
    getTypeCard/2,
    getExpansionCard/2,
    getNumeroCard/2,
    getNombreCard/2,
    getEvolucioDePoke/2,
    getPsPoke/2,
    getTipoPoke/2,
    getDebilidadPoke/2,
    getResistenciaPoke/2,
    getCosteRetiradaPoke/2,
    getEsExPoke/2,
    getHabilidadPoke/2,
    getAtaquesPoke/2,
    getTipoTrainer/2,
    getTextoTrainer/2,
    getPredicadoTrainer/2    
]).



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
  PokemonCard = [pokemon, Expansion, Numero, Nombre, EvolucionDe, Ps, Tipo, Debilidad, Resistencia, CosteRetirada, EsEx, Habilidad, Ataques].

initTrainerCard(Expansion, Numero, Nombre, Tipo, Texto, P, TrainerCard) :-
  TrainerCard = [trainer, Expansion, Numero, Nombre, Tipo, Texto, P].


% ======================================================
% ==================== SELECTORES ======================
% ======================================================

% =========== (GENERALES) ============
getTypeCard([Type | _], Type).
getExpansionCard([_, Expansion | _], Expansion).
getNumeroCard([_, _, Numero | _], Numero).
getNombreCard([_, _, _, Nombre | _], Nombre).
% =========== (Tipo: Pokemon) ==========
getEvolucioDePoke([_, _, _, _, EvolucionDe | _], EvolucionDe).
getPsPoke([_, _, _, _, _, Ps | _], Ps).
getTipoPoke([_, _, _, _, _, _, Tipo | _], Tipo).
getDebilidadPoke([_, _, _, _, _, _, _, Debilidad | _], Debilidad).
getResistenciaPoke([_, _, _, _, _, _, _, _, Resistencia | _], Resistencia).
getCosteRetiradaPoke([_, _, _, _, _, _, _, _, _, CosteRetirada | _], CosteRetirada).
getEsExPoke([_, _, _, _, _, _, _, _, _, _, EsEx | _], EsEx).
getHabilidadPoke([_, _, _, _, _, _, _, _, _, _, _, Habilidad | _], Habilidad).
getAtaquesPoke([_, _, _, _, _, _, _, _, _, _, _, _, Ataques | _], Ataques).
% ============ (Tipo: Entrenador) ==========
getTipoTrainer([_, _, _, _, TipoEntrenador | _], TipoEntrenador).
getTextoTrainer([_, _, _, _, _, Texto | _], Texto).
getPredicadoTrainer([_, _, _, _, _, _, Predicado | _], Predicado).



    
    
    
    
