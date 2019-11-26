defmodule ColaPasiva do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> {:queue.new, 0} end, name: __MODULE__)
  end

  def get_state do
    Agent.get(__MODULE__, &(&1))
  end

  def insert(msg, deman) do
    Agent.update(__MODULE__, fn {state_queue, _} -> {:queue.in(msg, state_queue), deman} end)
    IO.puts("state after insert -> ")
    IO.puts(get_state())
  end

  def remove(msg, deman) do
    Agent.update(__MODULE__, fn {state_queue, _} -> {:queue.from_list(:lists.delete(msg, :queue.to_list(state_queue))), deman} end)
    IO.puts("state after remove -> ")
    IO.puts(get_state())
  end

end
