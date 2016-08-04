defmodule An.AuthCitoyen do
  import Plug.Conn

  alias An.Citoyen
  alias An.Repo

  def init(_opts) do
  end

  def call(conn, _opts) do
    claims = Map.get(conn.assigns, :joken_claims)

    case Repo.get(Citoyen, Map.get(claims, "sub")) do
      nil -> conn |> send_resp(401, "Unauthorized") |> halt
      citoyen -> assign(conn, :citoyen, citoyen)
    end
  end
end
