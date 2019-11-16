defmodule Consumer do
  use GenStage

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
      IO.inspect {self(), event}
    end
    {:noreply, [], state}
  end
end
