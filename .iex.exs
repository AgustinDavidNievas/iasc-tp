 {:ok, pid_cola_pasiva1} =  Agent.start_link(fn -> {:queue.new, 0} end, name: :agent1)
 {:ok, pid_cola_pasiva2} =  Agent.start_link(fn -> {:queue.new, 0} end, name: :agent2)

 ColaPasiva.get_state(pid_cola_pasiva1)


{:ok, colaUnoPid} = ColaActivaDynamicSupervisor.start_child(:cola_uno, pid_cola_pasiva1)
{:ok, colaDosPid} = ColaActivaDynamicSupervisor.start_child(:cola_dos, pid_cola_pasiva2)

{:ok, consumerUnoPid} = ConsumerDynamicSupervisor.start_child(:uno)
{:ok, consumerDosPid} = ConsumerDynamicSupervisor.start_child(:dos)

GenStage.sync_subscribe(consumerUnoPid, to: colaUnoPid)
GenStage.sync_subscribe(consumerUnoPid, to: colaDosPid)
GenStage.sync_subscribe(consumerDosPid, to: colaUnoPid)

Router.agregar_cola("uno", colaUnoPid)
Router.agregar_cola("dos", colaDosPid)

ColaPasiva.get_state(pid_cola_pasiva1)

