:- module(tda_attack, [initAttack/6,
                       getCostAttack/2,
                       getNombreAttack/2,
                       getDescripcionAttack/2,
                       getDanoAttack/2,
                       getPredicadoAttack/2]).


% =============================
% ========= TDA ATTACK ========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% cost -> List ELEMENT-TYPE
% nombre -> String
% descripción -> String
% predicado-daño -> P


% ========= CONSTRUCTOR =======
initAttack(Cost, Nombre, Descripcion, Dano, P, Attack):-
  Attack = [Cost, Nombre, Descripcion, Dano, P].

% ========= SELECTORES ========
getCostAttack([Cost, _, _, _, _], Cost).
getNombreAttack([_, Nombre, _, _, _], Nombre).
getDescripcionAttack([_, _, Descripcion, _, _], Descripcion).
getDanoAttack([_, _, _, Dano, _], Dano).
getPredicadoAttack([_, _, _, _, P], P).




