-module(max)
-export([max/0])

max([]) -> undefined;
max([E]) -> E;
max([Head || Tail]) -> 
    lists:foldl(
        fun(E, Acc) -> if E > Acc -> E  )

