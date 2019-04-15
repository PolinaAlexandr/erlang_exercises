-module(my_gs).
-export([start/0, add/2, remove/2, check/2, show/1, stop/1]).
-export([loop/1]).


start() ->
    io:fwrite("starting custom gen_server at Pid ~p~n", [self()]),
    InitialState = [],
    LoopPid = spawn(?MODULE, loop, [InitialState]),
    show(LoopPid),
    add(LoopPid, 3),
    check(LoopPid, 3),
    show(LoopPid),
    stop(LoopPid).

add(Pid, Item) ->
    Pid ! {add, Item}.
    
remove(Pid, Item) ->
    Pid ! {remove, Item}.
    
check(Pid, Item) ->
    Pid ! {check, Item}.
    
show(Pid) ->
    Pid ! show.
    
stop(Pid) ->
    Pid ! stop.

loop(State) ->
    io:fwrite("process ~p entered the loop, brother ~n", [self()]),
    receive
        {add, Item} -> NewState = [Item | State],
                       ?MODULE:loop(NewState);
        {remove, Item} -> NewState = lists:delete(Item, State),
                          ?MODULE:loop(NewState);
        {check, Item} -> Res = lists:member(Item, State),
                         io:fwrite("~p~n", [Res]),
                         ?MODULE:loop(State);
        show -> io:fwrite("~p~n", [State]),
                ?MODULE:loop(State);
        stop -> io:format("~p stops now ~n", [self()]);
        Msg -> io:fwrite("ERROR: ~p receive unknown msg ~p~n", [self(), Msg]),
               ?MODULE:loop(State)
    end.
