defmodule ColaPasiva do
  use Agent

  def init(arg) do
    { :ok, arg }
  end

  def start_link() do
    Agent.start_link(fn -> {:queue.new, 0} end, name: __MODULE__)
  end
  def get_state(pid_agent) do
    Agent.get(pid_agent, &(&1))
  end

  def insert(pid_agent, msg, deman) do
    Agent.update(pid_agent, fn {state_queue, _} -> {:queue.in(msg, state_queue), deman} end)
  end

  def remove(pid_agent, msg, deman) do
    Agent.update(pid_agent, fn {state_queue, _} -> {:queue.from_list(:lists.delete(msg, :queue.to_list(state_queue))), deman} end)
  end
end
