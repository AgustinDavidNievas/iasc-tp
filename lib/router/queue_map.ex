defmodule RegistroCola do
    
  def start_link do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def registar_cola(key, name) do
    Registry.register(__MODULE__, key, name)
  end

  def get_cola(key) do
    IO.inspect "Seleccionando cola..."
    Registry.lookup(__MODULE__, key)
  end
    
  # Registry.dispatch(
  #     Registry.RegistroCola, 
  #     key,
  #     fn entry -> dispatch_message(entry, data) end
  # )

end