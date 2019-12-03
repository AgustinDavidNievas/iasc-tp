defmodule ColaActiva do
  use GenStage

  def child_spec({id, dispatcher}) do
    name = Module.concat(__MODULE__, id)
    %{id: name, start: {__MODULE__, :start_link, [name, dispatcher]}, type: :worker}
  end

  def start_link(name, dispatcher) do
    GenStage.start_link(__MODULE__, dispatcher, name: name)
  end

  def init(dispatcher) do
    #GenStage.DemandDispatcher envia el mensaje a un solo consumer (usando fifo)
    #GenStage.BroadcastDispatcher envisa el mensaje a todos los consumer
    {:producer, {:queue.new, 0}, dispatcher: dispatcher}
  end

  def handle_call({:notify, event}, from, {queue, pending_demand}) do
    queue = :queue.in({from, event}, queue)
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
      {{:value, {from, event}}, queue} ->
        GenStage.reply(from, :ok)
        dispatch_events(queue, demand - 1, [event | events])
      {:empty, queue} ->
        {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end

end
