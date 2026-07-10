:- module(tda_attack, [initAttack,
                       getCostAttack,
                       getNombreAttack,
                       getDescripcionAttack,
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
initAttack(Cost, Nombre, Descripcion, P, Attack):-
  Attack = [Cost, Nombre, Descripcion, P].

% ========= SELECTORES ========
getCostAttack([Cost, _, _, _], Cost).
getNombreAttack([_, Nombre, _, _], Nombre).
getDescripcionAttack([_, _, Descripcion, _], Descripcion).
getPredicadoAttack([_, _, _, P], P).




