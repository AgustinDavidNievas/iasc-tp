defmodule Producer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(arg) do
    { :ok, arg }
  end

  def handle_call({:sync_notify, colaPid, msj, timeout}, _from, state) do
    sync_notify(colaPid, msj, timeout)
    {:reply, :ok, state}
  end

  def sync_notify(key, msj, timeout \\ 5000) do
    content = {self(), msj,  :calendar.local_time()}
    GenServer.call({:global, GlobalRouter}, {:send, key, content}, timeout)
  end

  def crazy_notify(key, msj, timeout \\ 5000) do
    mensajes = for _ <- 1..10, do: msj

    for mensaje <- mensajes do
      content = {self(), mensaje,  :calendar.local_time()}
      GenServer.call({:global, GlobalRouter}, {:send, key, content}, timeout)
    end
  end

end
