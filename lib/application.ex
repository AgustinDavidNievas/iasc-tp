defmodule Iasc_tp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Producer, [], id: 0),
      supervisor(ColaActivaSupervisor, []),#TODO Pareciera que me ignora el nombre que esta definido en el start_link del sup
      %{id: ConsumerDynamicSupervisor, start: {ConsumerDynamicSupervisor, :start_link, [[]]} }
    ]

    #El Iasc_tp.Supervisor seria el supervisor de supervisores
    opts = [strategy: :one_for_one, name: Iasc_tp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
