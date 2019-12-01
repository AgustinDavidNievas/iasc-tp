defmodule ConsumerDynamicSupervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(id) do
    #Ejemplo para agregar consumer:
    #ConsumerDynamicSupervisor.start_child(:uno)
    spec = {Consumer, id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def start_child(id, cola) do
    #Ejemplo para agregar consumer:
    #ConsumerDynamicSupervisor.start_child(:uno, cola)
    spec = {Consumer, {id, cola} }
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
