-module(records).
-compile(export_all).

-record(user, {name,
         gender = fem, 
         details=[]}).

first_usr() ->
    #user{name="Mila",
           gender = fem,
           details =["is 29 yp"]}.