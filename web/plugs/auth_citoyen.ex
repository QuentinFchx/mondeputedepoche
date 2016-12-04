defmodule An.AuthCitoyen do
  import Plug.Conn
  import Joken

  alias Joken.Token
  alias An.AuthService
  alias An.Citoyen
  alias An.Repo

  def init(_opts) do
  end

  def call(conn, _opts) do
    parse_auth(conn)
  end

  defp is_lazy_auth(conn) do
    Map.get(conn.private, :lazy_auth, false)
  end

  defp parse_auth(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token_string] ->
        token_string
        |> parse_token
        |> handle_token(conn)
        |> set_citoyen
      [] -> if is_lazy_auth(conn), do: conn, else: unauthorized(conn)
    end
  end

  defp parse_token(token_string) do
    AuthService.verify
    |> with_compact_token(token_string)
    |> verify
  end

  defp handle_token(token, conn) do
    case token do
      %Token{error: nil} = token -> assign(conn, :joken_claims, get_claims(token))
      %Token{error: message} -> unauthorized(conn)
    end
  end

  defp set_citoyen(conn) do
    sub =
      conn.assigns
      |> Map.get(:joken_claims)
      |> Map.get("sub")

    case Repo.get(Citoyen, sub) do
      nil -> unauthorized(conn)
      citoyen -> assign(conn, :citoyen, citoyen)
    end
  end

  defp unauthorized(conn) do
    conn
    |> send_resp(401, "Unauthorized")
    |> halt
  end
end
