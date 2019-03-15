# Erlang exercises
Erlang stady simple progects compilation
1)Initial setup:
```shell
    $ virtualenv .venv
    $ source .venv/bin/activate
    $ sudo apt-get update && sudo apt-get upgrade
    $ wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
    $ sudo dpkg -i erlang-solutions_1.0_all.deb
    $ sudo apt-get update
    $ sudo apt-get esl-erlang  
```
2)Run:
```shell
    $ erl -noshell -s helloworld start -s init stop
```
