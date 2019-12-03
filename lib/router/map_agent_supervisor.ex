defmodule RouterStateSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
        {RouterState, []}
    ]
    IO.inspect "Iniciando supervisor del estado del registry..."
    Supervisor.init(children, strategy: :one_for_one)
  end

  def children do
    Supervisor.which_children(__MODULE__)
  end
end