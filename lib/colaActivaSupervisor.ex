defmodule ColaActivaSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      #{ColaActiva, init_arg}
      worker(ColaActiva, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
