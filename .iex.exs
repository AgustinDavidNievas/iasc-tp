{:ok, pid_cola_pasiva1} = DynamicSupervisor.start_child(AgentsSupervisor, {Agent, fn -> {:queue.new, 0} end})
{:ok, pid_cola_pasiva2} = DynamicSupervisor.start_child(AgentsSupervisor, {Agent, fn -> {:queue.new, 0} end})

{:ok, colaUnoPid} = ColaActivaDynamicSupervisor.start_child(:uno, GenStage.BroadcastDispatcher, pid_cola_pasiva1)
{:ok, colaDosPid} = ColaActivaDynamicSupervisor.start_child(:dos, GenStage.BroadcastDispatcher, pid_cola_pasiva1)
{:ok, consumerUnoPid} = ConsumerDynamicSupervisor.start_child(:uno, colaUnoPid)
{:ok, consumerDosPid} = ConsumerDynamicSupervisor.start_child(:dos, colaDosPid)
{:ok, consumerTresPid} = ConsumerDynamicSupervisor.start_child(:tres, colaDosPid)

Router.add_queue("uno", colaUnoPid)
Router.add_queue("dos", colaDosPid)
