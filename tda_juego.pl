

% =============================
% ========== TDA JUEGO ========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% jugador1 -> Jugador
% jugador2 -> Jugador
% turno_actual -> int


% ========= CONSTRUCTOR =======
initJuego(Jugador1, Jugador2, turno_actual, Game):-
  Game = [Jugador1, Jugador2, turno_actual].

% ========= SELECTORES ========
getJugador1([Jugador1, _, _], Jugador1).







