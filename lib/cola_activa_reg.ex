defmodule ColaActivaReg do

  def start_link do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def registrar_cola_pasiva(pid) do
    Registry.register(__MODULE__, "cola-pasiva", pid)
  end

  def get_cola_pasiva() do
    Registry.lookup(__MODULE__, "cola-pasiva")
  end

end
