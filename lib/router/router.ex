defmodule Router do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_args) do
    {:ok, RegistroCola.recover}
  end

  def handle_call({:send, key, data}, _from, state) do
    cola = RegistroCola.get_cola(key)
    IO.inspect {"Router: recibi un msj y lo estoy redireccionando", self()}
    {status} = send_to_queue(cola, data)

    {:reply, status, state}
  end

  def agregar_cola(key, cola_id) do
    RegistroCola.registar_cola(key, cola_id)
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


