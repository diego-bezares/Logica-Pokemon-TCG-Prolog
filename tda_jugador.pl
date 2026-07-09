:- module(tda_jugador, [initJugador,
                       getMazoJugador,
                       getManoJugador,
                       getPokeActivoJugador,
                       getBancaJugador,
                       getDescarteJugador,
                       getPremiosJugador,
                       setMazoJugador,
                       setManoJugador,
                       setPokeActivoJugador,
                       setBancaJugador,
                       setDescarteJugador,
                       setPremiosJugador]).

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
setMazoJugador(JugadorIn, NuevoMazo, JugadorOut):-
  getManoJugador(JugadorIn, Mano),
  getPokeActivoJugador(JugadorIn, PokeActivo),
  getBancaJugador(JugadorIn, Banca),
  getDescarteJugador(JugadorIn, Descarte),
  getPremiosJugador(JugadorIn, Premios),
  JugadorOut = [NuevoMazo, Mano, PokeActivo, Banca, Descarte, Premios].

setManoJugador(JugadorIn, NuevaMano, JugadorOut):-
  getMazoJugador(JugadorIn, Mazo),
  getPokeActivoJugador(JugadorIn, PokeActivo),
  getBancaJugador(JugadorIn, Banca),
  getDescarteJugador(JugadorIn, Descarte),
  getPremiosJugador(JugadorIn, Premios),
  JugadorOut = [Mazo, NuevaMano, PokeActivo, Banca, Descarte, Premios].

setPokeActivoJugador(JugadorIn, NuevoPokeActivo, JugadorOut):-
  getMazoJugador(JugadorIn, Mazo),
  getManoJugador(JugadorIn, Mano),
  getBancaJugador(JugadorIn, Banca),
  getDescarteJugador(JugadorIn, Descarte),
  getPremiosJugador(JugadorIn, Premios),
  JugadorOut = [Mazo, Mano, NuevoPokeActivo, Banca, Descarte, Premios].

setBancaJugador(JugadorIn, NuevaBanca, JugadorOut):-
  getMazoJugador(JugadorIn, Mazo),
  getManoJugador(JugadorIn, Mano),
  getPokeActivoJugador(JugadorIn, PokeActivo),
  getDescarteJugador(JugadorIn, Descarte),
  getPremiosJugador(JugadorIn, Premios),
  JugadorOut = [Mazo, Mano, PokeActivo, NuevaBanca, Descarte, Premios].

setDescarteJugador(JugadorIn, NuevoDescarte, JugadorOut):-
  getMazoJugador(JugadorIn, Mazo),
  getManoJugador(JugadorIn, Mano),
  getPokeActivoJugador(JugadorIn, PokeActivo),
  getBancaJugador(JugadorIn, Banca),
  getPremiosJugador(JugadorIn, Premios),
  JugadorOut = [Mazo, Mano, PokeActivo, Banca, NuevoDescarte, Premios].

setPremiosJugador(JugadorIn, NuevoPremios, JugadorOut):-
  getMazoJugador(JugadorIn, Mazo),
  getManoJugador(JugadorIn, Mano),
  getPokeActivoJugador(JugadorIn, PokeActivo),
  getBancaJugador(JugadorIn, Banca),
  getDescarteJugador(JugadorIn, Descarte),
  JugadorOut = [Mazo, Mano, PokeActivo, Banca, Descarte, NuevoPremios].






