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
    {:consumer, :ok, subscribe_to: [ColaActiva]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      #Por ahora solo printeo porque no se que mas hacer con esto :P
      :timer.sleep(3000);#TODO parametrizar?, esto esta aca para hacer pruebas con el tiempo de consumo
      IO.inspect {self(), event}
    end
    {:noreply, [], state}
  end
end
