-module(lessn2).
-export([init/0, filter_females/1]).

init() ->
    [
     {user, "Bob", 39, male},
     {user, "Rob", 30, male},
     {user,"Sam", 20, fem},
     {user,"Lin", 12, male}

    ].

filter_females(Users) ->
    filter_females(Users, []). 

filter_females([], Acc) -> list:reverse(Acc);
filter_females([User | Tail], Acc) ->
    case User of
        {user, _, _, fem} -> filter_females(Tail, [User | Acc]);
        {user, _, _, male} -> filter_females(Tail, Acc)
            
    end.







