defmodule RouterSupervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
       worker(Router, [[name: {:global, GlobalRouter}]], restart: :transient)
    ]
    IO.puts "Iniciando supervisor del router..."
    Supervisor.init(children, strategy: :one_for_one)
  end
end