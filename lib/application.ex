defmodule Iasc_tp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      #worker(Iasc_tp.Producer, []),
      worker(ColaActiva, []),
      worker(Consumer, [], id: 1),
      worker(Consumer, [], id: 2),
      worker(Consumer, [], id: 3),
      worker(Consumer, [], id: 4)
    ]

    #El Iasc_tp.Supervisor seria el supervisor de supervisores
    opts = [strategy: :one_for_one, name: Iasc_tp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
