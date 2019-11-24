# IascTp

TP de Implementación de Arquitecturas Concurrentes

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `iasc_tp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:iasc_tp, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/iasc_tp](https://hexdocs.pm/iasc_tp).


## failover-takeover

dentro de la carpeta config, hacer un search and replace de 
```
"REEMPLAZAR-POR-NOMBRE-DEL-HOST-VER-README"
```
por el nombre del equipo local.



copiar a mano el contenido de la carpeta:
_build\dev\lib\gen_stage\ebin

dentro de la carpeta:
_build\dev\lib\iasc_tp\ebin


```comandos para windows
iex.bat --sname a -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/a"
iex.bat --sname b -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/b"
iex.bat --sname c -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/c"

```comandos para linux
iex --sname a -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/a"
iex --sname b -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/b"
iex --sname c -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --app iasc_tp --erl "-config config/c"

Se deben correr los 3 comandos en 3 terminales, en simultaneo, para que la app levante.


Para observar:

desde otro terminal correr:
windows:
iex.bat --cookie cookie

linux
iex --cookie cookie

En la consola del BEAM escribir:
:observer.start

Ir a la solapa "nodes" luego a "enable distribution"

node name:
observer

secret cookie:
cookie

Si todo es correcto en "nodes" ya figuran todos los nodos activos para poder observar