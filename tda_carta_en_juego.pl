:- module(tda_carta_en_juego, [initCartaEnJuego/7,
                               getId/2,
                               getCartaBase/2,
                               getCartasAsociadas/2,
                               getEnergias/2,
                               getDano/2,
                               getEstado/2]).


% =============================
% ==== TDA CARTA-EN-JUEGO =====
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% id -> List 
% carta-base -> Card 
% cartas-asociadas -> List
% energias -> List
% dano -> int
% estado -> String


% =============================
% ======== CONSTRUCTOR ========
% =============================
initCartaEnJuego(Id, CartaBase, CartasAsociadas, Energias, Dano, Estado, CartaEnJuego):-
  CartaEnJuego = [Id, CartaBase, CartasAsociadas, Energias, Dano, Estado].

% =============================
% ======== SELECTORES =========
% =============================
getId([Id, _, _, _, _, _], Id).
getCartaBase([_, CartaBase, _, _, _, _], CartaBase).
getCartasAsociadas([_, _, CartasAsociadas, _, _, _], CartasAsociadas).
getEnergias([_, _, _, Energias, _, _], Energias).
getDano([_, _, _, _, Dano, _], Dano).
getEstado([_, _, _, _, _, Estado], Estado).

  









