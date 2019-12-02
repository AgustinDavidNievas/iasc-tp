{:ok, pid_cola_pasiva1} =  Agent.start_link(fn -> {:queue.new, 0} end, name: :agent1)
{:ok, pid_cola_pasiva2} =  Agent.start_link(fn -> {:queue.new, 0} end, name: :agent2)

{:ok, colaUnoPid} = ColaActivaDynamicSupervisor.start_child(:uno, pid_cola_pasiva1)
{:ok, colaDosPid} = ColaActivaDynamicSupervisor.start_child(:dos, pid_cola_pasiva2)

{:ok, consumerUnoPid} = ConsumerDynamicSupervisor.start_child(:uno, colaUnoPid)
{:ok, consumerDosPid} = ConsumerDynamicSupervisor.start_child(:dos, colaDosPid)
{:ok, consumerTresPid} = ConsumerDynamicSupervisor.start_child(:tres, colaDosPid)

Router.agregar_cola("uno", colaUnoPid)
Router.agregar_cola("dos", colaDosPid)

