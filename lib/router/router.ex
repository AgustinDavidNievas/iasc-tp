defmodule Router do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call({:send, key, data}, _from, state) do
    cola = RegistroCola.get_cola(key)
    IO.inspect {"Router: recibi un msj y lo estoy redireccionando", self()}
    {status} = send_to_queue(cola, data)

    {:reply, status, state}
  end

  def handle_call({:add, key, pid}, _from, state) do
    {:reply, add_queue(key, pid), state}
  end

  def handle_call({:search, key}, _from, state) do
    {:reply, search_queue(key), state}
  end

  def search_queue(key) do
    RegistroCola.get_cola(key)
  end

  def add_queue(key, cola_id) do
    RegistroCola.registar_cola(key, cola_id)
  end

  def remove_queue(key) do
    RegistroCola.unregister_key(key)
  end

  defp send_to_queue(data, event, timeout \\ 50000)

  defp send_to_queue([{_, pid}], event, timeout) do
    GenServer.call(pid, {:notify, event}, timeout)

    {:message_sent}
  end

  defp send_to_queue([], _event, _timeout) do
    {:queue_not_found}
  end

end


