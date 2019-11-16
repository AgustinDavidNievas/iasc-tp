defmodule ColaActiva do
  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, {:queue.new, 0}, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_call({:notify, event}, from, {queue, pending_demand}) do
    IO.inspect {self(), :handle_call, event}

    queue = :queue.in({from, event}, queue)
    dispatch_events(queue, pending_demand, [])
  end

  def handle_demand(incoming_demand, {queue, pending_demand}) do
    dispatch_events(queue, incoming_demand + pending_demand, [])
  end

  defp dispatch_events(queue, 0, events) do
    IO.inspect {self(), :dispatch_events0, events}

    {:noreply, Enum.reverse(events), {queue, 0}}
  end

  defp dispatch_events(queue, demand, events) do
    IO.inspect {self(), :dispatch_events, events}

    case :queue.out(queue) do
      {{:value, {from, event}}, queue} ->
        #Como el producer hace un call, le respondo
        #TODO hacer que no responda y que el producer haga un cast?, me parece que esta mal que espere respuesta...
        GenStage.reply(from, :ok)
        dispatch_events(queue, demand - 1, [event | events])
      {:empty, queue} ->
        {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end

  #TODO esto tendria que estar en el producer
  def sync_notify(event, timeout \\ 50000) do
    GenStage.call(__MODULE__, {:notify, event}, timeout)
  end

end
