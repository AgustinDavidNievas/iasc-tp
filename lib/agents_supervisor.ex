defmodule AgentsSupervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: __MODULE__}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
