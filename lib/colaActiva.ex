defmodule ColaActiva do
  use GenStage

  def child_spec(id) do
    name = Module.concat(__MODULE__, id)
    %{id: name, start: {__MODULE__, :start_link, [name]}, type: :worker}
  end

  def start_link(name) do
    GenStage.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    #GenStage.DemandDispatcher envia el mensaje a un solo consumer (usando fifo)
    #GenStage.BroadcastDispatcher envisa el mensaje a todos los consumer
    {:producer, {:queue.new, 0}, dispatcher: GenStage.DemandDispatcher}
  end

  def handle_call({:notify, event}, from, {queue, pending_demand}) do
    IO.inspect {self(), :handle_call, event}

    queue = :queue.in({from, event}, queue)

    ColaPasiva.insert({from, event}, pending_demand)

    dispatch_events(queue, pending_demand, [])
  end

  def handle_demand(incoming_demand, {queue, pending_demand}) do
    IO.inspect {self(), :handle_demand, queue, pending_demand}

    dispatch_events(queue, incoming_demand + pending_demand, [])
  end

  defp dispatch_events(queue, 0, events) do
    IO.inspect {self(), :dispatch_events0, events}

    {:noreply, Enum.reverse(events), {queue, 0}}
  end

  defp dispatch_events(queue, demand, events) do
    IO.inspect {self(), :dispatch_events, events}

    case :queue.out(queue) do

      {{:value,{from, event}}, queue} ->

        GenStage.reply(from, :ok)

        IO.inspect {self(), :from, from}

        ColaPasiva.remove({from, event}, demand)

        dispatch_events(queue, demand - 1, [event | events])
      {:empty, queue} ->
        {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end

end
