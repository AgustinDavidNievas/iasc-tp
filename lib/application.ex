defmodule Iasc_tp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      ColaPasivaSupervisor,
      ProducerSupervisor,
      RegistroColaSupervisor,
      ColaActivaRegSup,
      RouterSupervisor,
      Endpoint,
      %{id: ColaActivaDynamicSupervisor, start: {ColaActivaDynamicSupervisor, :start_link, [[]]} },
      %{id: ConsumerDynamicSupervisor, start: {ConsumerDynamicSupervisor, :start_link, [[]]} },
    ]

    #El Iasc_tp.Supervisor seria el supervisor de supervisores
    opts = [strategy: :one_for_one, name: Iasc_tp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
