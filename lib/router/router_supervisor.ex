  defmodule RouterSupervisor do
  use Supervisor

  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      worker(RegistroCola, []),
      worker(Router, [[name: {:global, GlobalRouter}]])
    ]
    Logger.info("Iniciando supervisor del router...")
    Supervisor.init(children, strategy: :one_for_all)
  end

  def children do
    Supervisor.which_children(__MODULE__)
  end
end
