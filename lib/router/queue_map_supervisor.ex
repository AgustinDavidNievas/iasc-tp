defmodule RegistroColaSupervisor do
  use Supervisor

  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    Logger.info("Iniciando supervisor del mapa de colas...")
    children = [
      worker(RegistroCola, [])
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

  def children do
    Supervisor.which_children(__MODULE__)
  end

end
