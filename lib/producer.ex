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

  def sync_notify(colaPid, msj, timeout \\ 5000) do
    #TODO sacar colaPid y usar el nombre registrado del Router!!!
    GenServer.call(colaPid, {:notify, {self(), :calendar.local_time(),msj}}, timeout)
  end

  def crazy_notify(colaPid, msj, timeout \\ 5000) do
    #TODO sacar colaPid y usar el nombre registrado del Router!!!
    mensajes = for _ <- 1..10, do: msj

    for mensaje <- mensajes do
      GenServer.call(colaPid, {:notify, {self(), :calendar.local_time(),mensaje}}, timeout)
    end
  end

end
