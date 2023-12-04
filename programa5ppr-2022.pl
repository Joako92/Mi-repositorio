%HECHOS
%aspirante/2.
%aspirante(Nombre,Edad).
aspirante('Lara',23).
aspirante('Tina',18).
aspirante('Tovo',27).
aspirante('Vera',27).

%le_gusta/2.
%le_gusta(Nombre,Qu�LeGusta).
le_gusta('Lara','programar en Java').
le_gusta('Tina','pintar').
le_gusta('Tina','nataci�n').
le_gusta('Tina','tenis').
le_gusta('Tovo','cantar').
le_gusta('Tovo','f�tbol').
le_gusta('Tovo','escuchar m�sica').
le_gusta('Vera','remo').
le_gusta('Vera','f�tbol').


%sabe_nadar/1.
%sabe_nadar(NombreDeQuienSabeNadar).
sabe_nadar('Tina').
sabe_nadar('Vera').
%deportes_club/1.
%deportes_club([ListaDeportesDelClub]).
deportes_club(['f�tbol','b�squet','h�ndbol','v�ley','tenis','ciclismo','atletismo','nataci�n']).
%deportes_acu�ticos/1.
%deportes_acu�ticos([ListaDeportesAcu�ticos]).
deportes_acu�ticos(['nataci�n','danza acu�tica','remo','buceo']).


% 1) Para cada aspirante, todos los deportes que se practiquen en el club
% y que le guste (sin incluir otras
%actividades que no sean deportes).
%regla1/2.
%regla1(Nombre,DeporteDelClubQueLeGusta).
regla1(Nom,Dep):-aspirante(Nom,_),
                 le_gusta(Nom,Dep),
                 deportes_club(ListaDeportesClub),
                 member(Dep,ListaDeportesClub).


% 2) Para cada aspirante, todas las dem�s actividades que les gustan (sin
% incluir los deportes que se practican en el club).
regla2(Nom,Act):-aspirante(Nom,_),
                 le_gusta(Nom,Act),
                 deportes_club(ListaDeportesClub),
                 not(member(Act,ListaDeportesClub)).


% 3) Consultar si alg�n aspirante en particular, no le gusta ninguno de
% los deportes que se practican en el club.
le_gusta_alg�n_deporte(Nom):-aspirante(Nom,_),
                             le_gusta(Nom,Act),
                             deportes_club(LDC),
                             member(Act,LDC),
                             !.
no_les_gusta_ning�n_deporte(Nom):-not(le_gusta_alg�n_deporte(Nom)).

%4) �Cu�ntos deportes se pueden practicar en el club?
regla4(Cant):-deportes_club(LDC),
              length(LDC,Cant).

% 5) Listado de los deportes que se pueden practicar en el club,
% ordenados ascendentemente (desde la A
%hasta la Z).
regla5(LOAsc):-deportes_club(LDC),
               sort(LDC,LOAsc).

regla5_desc(LODesc):-regla5(LOAsc),
                     reverse(LOAsc,LODesc).


% 6) Listar los nombres de todos aquellos aspirantes que tengan m�s de
% cierta edad.
%regla6/2.
%regla6(EdadReferencia,ListaAGenarar).
regla6(Ref,Lista):-findall(Nom,(aspirante(Nom,Edad),Edad > Ref),Lista).


% 7) Listar los nombres de todos aquellos aspirantes que les guste alguna
% de las actividades que se practiquen en el club. (realizar de tarea)

%8) �Cu�ntos aspirantes hay?
lista_aspirantes(Lista):-findall(Nom,aspirante(Nom,_),Lista).

regla8(CantAsp):-lista_aspirantes(ListaAsp),
                 length(ListaAsp,CantAsp).

regla8_v2(CantAsp):-findall(Nom,aspirante(Nom,_),Lista),
                    length(Lista,CantAsp).


%9) �Qu� valor suman las edades de todos los aspirantes?
lista_edades(Lista):-findall(Edad,aspirante(_,Edad),Lista).
regla9(SumaEdades):-lista_edades(Lista),
                    sumlist(Lista,SumaEdades).


%10) �Cu�l es la edad promedio de los aspirantes?
regla10(Prom):-regla8(Cant),((Cant>0,regla9(Suma),Prom is Suma/Cant,!);
                            (Cant=:=0,Prom is 0,!)).

% Para que un aspirante pueda ser candidato al puesto, debe cumplir
% m�nimamente los siguientes
% requisitos: que sepa nadar, � que le guste alg�n deporte de los que se
% practiquen en el club y que est�
% relacionado con alguna actividad acu�tica (tener en cuenta que no todas
% estas actividades que son
%acu�ticas son realizadas en el club).
% El listado de las actividades acu�ticas es: nataci�n, remo, danza
% acu�tica y buceo.
% 11) Consultar si alg�n aspirante en particular re�ne los requisitos
% para ser un candidato al puesto.
regla11(Nom):-aspirante(Nom,_),((sabe_nadar(Nom),!);
                                (le_gusta(Nom,Act),
                                 deportes_club(LDC),
                                  member(Act,LDC),
                                 deportes_acu�ticos(LDA),
                                 member(Act,LDA),!)
                               ).

% 12) Adaptar la regla anterior para que se muestren los nombres de todos
% aquellos aspirantes que re�nan los requisitos para ser candidato.
regla12(ListaCandi):-findall(Nom,(aspirante(Nom,_),
                                  regla11(Nom)
                                 ),                ListaCandi).

%13)�Cu�ntos aspirantes son candidatos?
regla13(CantCandi):-regla12(ListaCandi),
                    length(ListaCandi,CantCandi).

% 14) Generar un listado con los nombres de aquellos aspirantes con m�s
% de 21 a�os. (realizar de tarea)
% 15) Generar un listado con los nombres de aquellos participantes que
% tengan m�s de 21 a�os o que al menos, sepan nadar. (realizar de tarea)
%16) �Cu�l es la edad del aspirante con mayor edad?
regla16(May):-lista_edades(Lista),
              sort(Lista,ListaAsc),
              length(ListaAsc,Cant),
              nth1(Cant,ListaAsc,May).

%17) �Cu�l es la edad del aspirante m�s joven? (realizar de tarea)

%18) �Qui�nes son los aspirantes con la mayor edad?
regla18(ListaNomMay):-regla16(May),
                      findall(Nom,(aspirante(Nom,Edad),
                                   Edad=:=May),        ListaNomMay).
% 19) �Qu� diferencia de edad hay entre el aspirante de mayor edad con el
% m�s joven? (realizar de tarea)

% 20) Conocer si todos los aspirantes son mayores de edad (es decir, que
% su edad sea 18 a�os o m�s).(realizar de tarea)


% 21) GENERAR una lista en la que cada elemento sea una tupla que
% incluya, el nombre y la edad, de todos aquellos aspirantes que tengan
% m�s de cierta edad.

regla21(R,Lista):-findall((N,E),(aspirante(N,E),
                                 E>R),          Lista).





















