defmodule ColaActivaDynamicSupervisor do
  use DynamicSupervisor

  def start_link do
    DynamicSupervisor.start_link(__MODULE__, name: __MODULE__)
  end

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(id, pid_cola_pasiva) do
    #Ejemplo para agregar una cola:
    #ColaActivaDynamicSupervisor.start_child(:uno)
    spec = {ColaActiva, {id, pid_cola_pasiva}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

end
