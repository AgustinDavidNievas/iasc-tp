defmodule Producer do
  use GenServer
  #TODO creo que con un GenServer alcanza, pero capaz que tendria que ser un GenSage?

  def start_link do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  def handle_call({:sync_notify, event, timeout}, _from, state) do
    #TODO hacer privada a la funcion sync_notify, crear otra async y hacer pattern matching aca?
    sync_notify(event, timeout)
    {:reply, :ok, state}
  end

  def sync_notify(event, timeout \\ 5000) do
    GenServer.call(ColaActiva, {:notify, event}, timeout)
  end
end
