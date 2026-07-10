

% =============================
% ========= TDA ATTACK ========
% =============================

% ======= REPRESENTACIÓN ======
% Una lista de los siguientes 
% elementos:

% cost -> List ELEMENT-TYPE
% nombre -> String
% descripción -> String
% función-daño -> F


% ========= CONSTRUCTOR =======
initAttack(Cost, Nombre, Descripcion, P, Attack):-
  Attack = [Cost, Nombre]
