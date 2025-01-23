:- dynamic datashows_disponiveis/1, datashows_alocados/1.

% Inicializa os datashows disponíveis e alocados
datashows_disponiveis([datashow1, datashow2, datashow3]).
datashows_alocados([]).

% Verifica se um datashow está disponível
disponivel(Datashow) :-
    datashows_disponiveis(Disponiveis),
    member(Datashow, Disponiveis).

% Aloca um datashow
alocar(Datashow) :-
    disponivel(Datashow),
    atualizar_lista(datashows_disponiveis, Disponiveis, Datashow, NovoDisponiveis),
    atualizar_lista(datashows_alocados, Alocados, Datashow, NovosAlocados),
    write(Datashow), write(' Datashow alocado.').

% Desaloca um datashow
desalocar(Datashow) :-
    datashows_alocados(Alocados),
    member(Datashow, Alocados),
    atualizar_lista(datashows_alocados, Alocados, Datashow, NovoAlocados, remove),
    datashows_disponiveis(Disponiveis),
    atualizar_lista(datashows_disponiveis, Disponiveis, Datashow, NovosDisponiveis, adiciona),
    write(Datashow), write(' Datashow desalocado.').

% Atualiza uma lista de datashows
atualizar_lista(Predicado, ListaAtual, Datashow, NovaLista) :-
    retract(Predicado(ListaAtual)),
    select(Datashow, ListaAtual, NovaLista),
    assertz(Predicado(NovaLista)).

atualizar_lista(Predicado, ListaAtual, Datashow, NovaLista, remove) :-
    retract(Predicado(ListaAtual)),
    select(Datashow, ListaAtual, NovaLista),
    assertz(Predicado(NovaLista)).

atualizar_lista(Predicado, ListaAtual, Datashow, NovaLista, adiciona) :-
    retract(Predicado(ListaAtual)),
    append([Datashow], ListaAtual, NovaLista),
    assertz(Predicado(NovaLista)).

% Lista os datashows disponíveis
listar_disponiveis :-
    datashows_disponiveis(Disponiveis),
    write('Datashows disponíveis: '), writeln(Disponiveis).

% Lista os datashows alocados
listar_alocados :-
    datashows_alocados(Alocados),
    write('Datashows alocados: '), writeln(Alocados).
