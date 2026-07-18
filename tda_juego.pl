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
getTurnoActual([_, _, TurnoActual], TurnoActual).

% ======== MODIFICADORES ======
setJugador1([_, Jugador2, TurnoActual], NuevoJugador1, NewGame):-
  NewGame = [NuevoJugador1, Jugador2, TurnoActual].

setJugador2([Jugador1, _, TurnoActual], NuevoJugador2, NewGame):-
  NewGame = [Jugador1, NuevoJugador2, TurnoActual].  

setTurnoActual([Jugador1, Jugador2, _], NuevoTurno, NewGame):-
  NewGame = [Jugador1, Jugador2, NuevoTurno].
  NewGame = [Jugador1, Jugador2, NuevoTurno].




