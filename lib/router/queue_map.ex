defmodule RegistroCola do
  
  def start_link do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def registar_cola(key, name) do
    # Guardo el valor primero en el agent para luego poder recuperarlo
    RouterState.add({key, name})
    register_key(key, name)
  end

  defp register_key(key, name) do
    Registry.register(__MODULE__, key, name)    
  end

  def unregister_key(key) do
    Registry.unregister(__MODULE__, key)
  end

  def recover do
    IO.inspect "Recuperando estados..."
    for {key, value} <- RouterState.values do
      register_key(key, value)
    end
  end

  def get_cola(key) do
    IO.inspect "Seleccionando cola..."
    Registry.lookup(__MODULE__, key)
  end

  def values do
    Registry.keys(__MODULE__, self())
  end

end