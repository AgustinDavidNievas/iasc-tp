defmodule Consumer do
  use GenStage

  def child_spec({id, cola}) do
    name = Module.concat(__MODULE__, id)
    %{id: name, start: {__MODULE__, :start_link, [name, cola]}, type: :worker}
  end

  def start_link(name, cola) do
    IO.inspect {"Start Link",name, cola}
    GenStage.start_link(__MODULE__, cola, name: name)
  end

  def init(cola) do
    {:consumer, [], subscribe_to: [cola]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      :timer.sleep(3000);#TODO parametrizar
      IO.inspect {"Consumidor: ", self()," recibi: ", event}
    end
    {:noreply, [], state}
  end
end
