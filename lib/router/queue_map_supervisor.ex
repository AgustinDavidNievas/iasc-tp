defmodule RegistroColaSupervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    IO.puts "Iniciando supervisor del mapa de colas..."    
    children = [
       worker(RegistroCola, [])
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end