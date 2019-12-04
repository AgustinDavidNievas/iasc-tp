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

### Registrar una cola 
Utilizamos un actor **Router**, que se encarga de enviar mensajes a una cola recibiendo una clave:

```
GenServer.call({:global, GlobalRouter}, {:add, "key", cola_pid}, timeout)
```

### Enviar un mensaje a una cola
Utilizamos un actor **Producer**, que se encarga de enviar mensajes a una cola de la siguiente manera:

```
Producer.sync_notify("key", "message")
```
Donde "key" es el "id" de la cola, y "message" representa lo que queremos enviar


## failover-takeover

dentro de la carpeta config, hacer un search and replace de 
```
"REEMPLAZAR-POR-NOMBRE-DEL-HOST-VER-README"
```
por el nombre del equipo local.


### comandos para windows
```
iex.bat --sname a -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/a" -S mix
iex.bat --sname b -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/b" -S mix
iex.bat --sname c -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/c" -S mix

```

### comandos para linux
```
iex --sname a -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/a" -S mix
iex --sname b -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/b" -S mix
iex --sname c -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/c" -S mix
```

Se deben correr los 3 comandos en 3 terminales, en simultaneo, para que la app levante.


### Para observar:

desde otro terminal correr:
windows:
```
iex.bat --cookie cookie
```
linux
```
iex --cookie cookie
```

En la consola del BEAM escribir:
```
:observer.start
```

Ir a la solapa "nodes" luego a "enable distribution"

node name:
observer

secret cookie:
cookie

Si todo es correcto en "nodes" ya figuran todos los nodos activos para poder observar


### Correr utilizando docker

Utilizamos un docker-compose que mantiene a tres containers de elixir conectados a una nextork. Para levantarlo, corremos el siguiente comando (estando parados en el path principal).
```
docker-compose up -d
```

#### 1- Consola interactiva en un container
Ingresar en un container:
```
docker-compose exec elixir_uno bash
```
Una vez dentro, ingresar:
```
iex -S mix
```

#### 2- Failover-takeover entre los diferentes nodos (utilizando docker)
En diferentes consolas, entrar a cada container:
```
docker-compose exec elixir_uno bash
docker-compose exec elixir_dos bash
docker-compose exec elixir_tres bash
```
una vez adentro, por cada container, correr:
```
./start_a_docker (en nodo uno)
./start_b_docker (en nodo dos)
./start_c_docker (en nodo tres)
```
Cada uno de estos corre el siguiente comando
```
iex --sname a -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/docker/a-docker" -S mix
iex --sname b -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/docker/b-docker" -S mix
iex --sname c -pa _build/dev/lib/iasc_tp/ebin/ --cookie cookie --erl "-config config/docker/c-docker" -S mix
```
