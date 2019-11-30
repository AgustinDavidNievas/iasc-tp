defmodule Consumer do
  use GenStage

  def child_spec(id) do
    name = Module.concat(__MODULE__, id)
    %{id: name, start: {__MODULE__, :start_link, [name]}, type: :worker}
  end

  def start_link do
    GenStage.start_link(__MODULE__, :ok)
  end

  def start_link(name) do
    GenStage.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    #como ahora la cola es dinamica no puedo usar "subscribe_to: [ColaActiva]" :(
    #TODO ver si le puedo pasar el subscribe_to aca en el init...
    {:consumer, []}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect {"Consumidor: recibi un mensaje", events}
    end
    {:noreply, [], state}
  end
end
