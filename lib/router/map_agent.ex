defmodule RouterState do
  use Agent

  def init(_init_arg) do
    {:ok}
  end

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end 

  def start_link(initial_value, name) do
    Agent.start_link(fn -> initial_value end, name: name)
  end 

  def values do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def add(value) do
    Agent.update(__MODULE__, fn state -> [value | state] end)
  end
end