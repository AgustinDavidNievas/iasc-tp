defmodule RouterEndpoint do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "/" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, message())
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp message do
    #Mensaje a mostrar al cliente en formato JSON
    Poison.encode!(%{
      response: "IASC_TP - Grupo 6"
    })
  end
end
