{:ok, colaUnoPid} = ColaActivaDynamicSupervisor.start_child(:uno)
{:ok, colaDosPid} = ColaActivaDynamicSupervisor.start_child(:dos)
{:ok, consumerUnoPid} = ConsumerDynamicSupervisor.start_child(:uno, colaUnoPid)
{:ok, consumerDosPid} = ConsumerDynamicSupervisor.start_child(:dos, colaDosPid)
{:ok, consumerTresPid} = ConsumerDynamicSupervisor.start_child(:tres, colaDosPid)

Router.agregar_cola("uno", colaUnoPid)
Router.agregar_cola("dos", colaDosPid)
