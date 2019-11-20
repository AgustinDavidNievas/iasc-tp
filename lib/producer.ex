defmodule Producer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(arg) do
    { :ok, arg }
  end

  def handle_call({:sync_notify, msj, timeout}, _from, state) do
    #TODO hacer privada a la funcion sync_notify, crear otra async y hacer pattern matching aca?
    sync_notify(msj, timeout)
    {:reply, :ok, state}
  end

  def sync_notify(msj, timeout \\ 5000) do
    GenServer.call(ColaActiva, {:notify, {self(), :calendar.local_time(),msj}}, timeout)
  end

  def crazy_notify(msj, timeout \\ 5000) do
    mensajes = for _ <- 1..10, do: msj

    for mensaje <- mensajes do
      GenServer.call(ColaActiva, {:notify, {self(), :calendar.local_time(),mensaje}}, timeout)
    end
  end

end
