-module(str).
-export([trim/1]).

% trim(Str) ->
% Pred = fun(Char) -> Char == 32 end.
% Str2 = lists:dropwhile(Pred, Str),
% Str3 = lists:reverse(Str2),
% Str4 = lists:reverse(Pred, Str3), 
% lists:reverse(Str4).

-record(state{
         met_non_space = false,
         result = [], 
         space = []
        }).


trim(Str) ->
    trim(Str, #state).

trim([], #state{result = Res} -> lists:reverse(Res));

trim([?SPACE | Tail], #state{met_non_space = false} = State) ->
    trim(Tail, State).

trim([Char | Tail], state{met_non_space = false, result = false, result = Res} = State) ->
    State1 = State#state{met_non_space = true, result = [Char | Res]},
    trim(Tail, Srate1);

trim([Char | Tail])


