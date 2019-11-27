defmodule Iasc_tp.Application do
  use Application

  #{:ok, colaUnoPid} = ColaActivaDynamicSupervisor.start_child(:uno)
  #{:ok, consumerUnoPid} = ConsumerDynamicSupervisor.start_child(:uno)
  #{:ok, consumerDosPid} = ConsumerDynamicSupervisor.start_child(:dos)
  #GenStage.sync_subscribe(consumerUnoPid, to: colaUnoPid)
  #GenStage.sync_subscribe(consumerDosPid, to: colaUnoPid)
  
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      ProducerSupervisor,
      RegistroColaSupervisor,
      RouterSupervisor,
      %{id: ColaActivaDynamicSupervisor, start: {ColaActivaDynamicSupervisor, :start_link, [[]]} },
      %{id: ConsumerDynamicSupervisor, start: {ConsumerDynamicSupervisor, :start_link, [[]]} }
    ]

    #El Iasc_tp.Supervisor seria el supervisor de supervisores
    opts = [strategy: :one_for_one, name: Iasc_tp.Supervisor]
    Supervisor.start_link(children, opts)
    # ConsumerDynamicSupervisor.start_child(:uno)
    # RegistroCola.start
  end
end
