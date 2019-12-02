defmodule ColaActiva do
  use GenStage

  def child_spec({id, pid_cola_pasiva}) do
    name = Module.concat(__MODULE__, id)
    %{id: name, start: {__MODULE__, :start_link, [name, pid_cola_pasiva]}, type: :worker}
  end

  def start_link(name, pid_cola_pasiva) do

    ColaActivaReg.registrar_cola_pasiva(pid_cola_pasiva)

    GenStage.start_link(__MODULE__,{:ok, pid_cola_pasiva}, name: name)
  end


  def init({:ok, pid_cola_pasiva}) do
    #GenStage.DemandDispatcher envia el mensaje a un solo consumer (usando fifo)
    #GenStage.BroadcastDispatcher envisa el mensaje a todos los consumer

    {:producer, ColaPasiva.get_state(pid_cola_pasiva), dispatcher: GenStage.DemandDispatcher}
  end


  def handle_call({:notify, event}, from, {queue, pending_demand}) do
    queue = :queue.in({from, event}, queue)

    cola_pasiva_agent = ColaActivaReg.get_cola_pasiva()

    ColaPasiva.insert(cola_pasiva_agent, {from, event}, pending_demand)

    dispatch_events(queue, pending_demand, [])
  end

  def handle_demand(incoming_demand, {queue, pending_demand}) do
    dispatch_events(queue, incoming_demand + pending_demand, [])
  end

  defp dispatch_events(queue, 0, events) do
    {:noreply, Enum.reverse(events), {queue, 0}}
  end

  defp dispatch_events(queue, demand, events) do
    case :queue.out(queue) do

      {{:value,{from, event}}, queue} ->

        GenStage.reply(from, :ok)

        cola_pasiva_agent = ColaActivaReg.get_cola_pasiva()

        ColaPasiva.remove(cola_pasiva_agent, {from, event}, demand)

        dispatch_events(queue, demand - 1, [event | events])
      {:empty, queue} ->
        {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end

end
