  defmodule RouterSupervisor do
  use Supervisor

  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
       worker(Router, [[name: {:global, GlobalRouter}]], restart: :transient)
    ]
    Logger.info("Iniciando supervisor del router...")
    Supervisor.init(children, strategy: :one_for_one)
  end

  def children do
    Supervisor.which_children(__MODULE__)
  end
end
