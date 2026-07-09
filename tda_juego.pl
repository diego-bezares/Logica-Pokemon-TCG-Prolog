:- module(tda_juego, [initJuego,
                     getJugador1,
                     getJugador2,
                     getTurnoActual,
                     setJugador1,
                     setJugador2,
                     setTurnoActual]).

% =============================
% ========== TDA JUEGO ========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% jugador1 -> Jugador
% jugador2 -> Jugador
% TurnoActual -> int


% ========= CONSTRUCTOR =======
initJuego(Jugador1, Jugador2, TurnoActual, Game):-
  Game = [Jugador1, Jugador2, TurnoActual].

% ========= SELECTORES ========
getJugador1([Jugador1, _, _], Jugador1).
getJugador2([_, Jugador2, _], Jugador2).
getTurnoActual([_, _, TurnoActual]).

% ======== MODIFICADORES ======
setJugador1(Game, NuevoJugador1, NewGame):-
  getJugador2(Game, Jugador2),
  getTurnoActual(Game, TurnoActual),
  NewGame = [NuevoJugador1, Jugador2, TurnoActual].

setJugador2(Game, NuevoJugador2, NewGame):-
  getJugador1(Game, Jugador1),
  getTurnoActual(Game, TurnoActual),
  NewGame = [Jugador1, NuevoJugador2, TurnoActual].  

setTurnoActual(Game, NuevoTurno, NewGame):-
  getJugador1(Game, Jugador1),
  getJugador2(Game, Jugador2),
  NewGame = [Jugador1, Jugador2, NuevoTurno].




