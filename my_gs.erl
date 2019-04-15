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
  call(Pid, {add, Item}).

remove(Pid, Item) ->
    call(Pid, {remove, Item}).

check(Pid, Item) ->
    call(Pid, {check, Item}).

show(Pid) ->
    call(Pid, show).

    
stop(Pid) ->
    Pid ! stop.

call(Pid, Msg) ->
    Pid ! {self(), Msg},
    receive 
        {reply, Reply} -> Reply
    after 5000 -> noreply
    end.

loop(State) ->
    io:fwrite("process ~p entered the loop, brother ~n", [self()]),
    receive
        {From, {add, Item}} -> NewState = [Item | State],
                               From ! {reply, ok}, 
                               ?MODULE:loop(NewState);
        {From,{remove, Item}} -> NewState = lists:delete(Item, State),
                                 From ! {reply, ok},  
                                 ?MODULE:loop(NewState);
        {From, {check, Item}} -> Res = lists:member(Item, State),
                                 From ! {reply, Res},
                                 ?MODULE:loop(State);
        {From, show} -> From ! {reply, State},
                        ?MODULE:loop(State);
        stop -> io:format("~p stops now ~n", [self()]);
        Msg -> io:fwrite("ERROR: ~p receive unknown msg ~p~n", [self(), Msg]),
               ?MODULE:loop(State)
    end.
