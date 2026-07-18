:- module(tda_jugador, [initJugador/7,
                       getMazoJugador/2,
                       getManoJugador/2,
                       getPokeActivoJugador/2,
                       getBancaJugador/2,
                       getDescarteJugador/2,
                       getPremiosJugador/2,
                       setMazoJugador/3,
                       setManoJugador/3,
                       setPokeActivoJugador/3,
                       setBancaJugador/3,
                       setDescarteJugador/3,
                       setPremiosJugador/3]).

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
getBancaJugador([_, _, _, Banca, _, _], Banca).
getDescarteJugador([_, _, _, _, Descarte, _], Descarte).
getPremiosJugador([_, _, _, _, _, Premios], Premios).

% ======== MODIFICADORES ======
setMazoJugador([_, Mano, PokeActivo, Banca, Descarte, Premios], NuevoMazo, JugadorOut):-
  JugadorOut = [NuevoMazo, Mano, PokeActivo, Banca, Descarte, Premios].

setManoJugador([Mazo, _, PokeActivo, Banca, Descarte, Premios], NuevaMano, JugadorOut):-
  JugadorOut = [Mazo, NuevaMano, PokeActivo, Banca, Descarte, Premios].

setPokeActivoJugador([Mazo, Mano, _, Banca, Descarte, Premios], NuevoPokeActivo, JugadorOut):-
  JugadorOut = [Mazo, Mano, NuevoPokeActivo, Banca, Descarte, Premios].

setBancaJugador([Mazo, Mano, PokeActivo, _, Descarte, Premios], NuevaBanca, JugadorOut):-
  JugadorOut = [Mazo, Mano, PokeActivo, NuevaBanca, Descarte, Premios].

setDescarteJugador([Mazo, Mano, PokeActivo, Banca, _, Premios], NuevoDescarte, JugadorOut):-
  JugadorOut = [Mazo, Mano, PokeActivo, Banca, NuevoDescarte, Premios].

setPremiosJugador([Mazo, Mano, PokeActivo, Banca, Descarte, _], NuevoPremios, JugadorOut):-
  JugadorOut = [Mazo, Mano, PokeActivo, Banca, Descarte, NuevoPremios].






