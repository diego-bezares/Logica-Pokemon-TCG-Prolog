:- module(tda_attack, [initAttack,
                       getCostAttack,
                       getNombreAttack,
                       getDescripcionAttack,
                       getDanoAttack,
                       getPredicadoAttack]).


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




