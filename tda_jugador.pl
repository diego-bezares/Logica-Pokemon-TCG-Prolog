

% =============================
% ======== TDA JUGADOR ========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% mazo -> List (deck)
% mano -> List (card)
% poke activo -> Card o null
% banca -> List (card)
% descarte -> List (card)
% premios -> List (card)


% ========= CONSTRUCTOR =======
initJugador(Mazo, Mano, PokeActivo, Banca, Descarte, Premios, Jugador):-
  Jugador = [Mazo, Mano, PokeActivo, Banca, Descarte, Premios].

% ======== SELECTORES =========
getMazoJugador([Mazo, _, _, _, _, _], Mazo).
getManoJugador([_, Mano, _, _, _, _], Mano).
getPokeActivoJugador([_, _, PokeActivo, _, _, _], PokeActivo). 








