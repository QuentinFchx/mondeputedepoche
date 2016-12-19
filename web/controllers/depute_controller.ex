defmodule An.DeputeController do
  use An.Web, :controller

  alias An.Depute

  def show(conn, %{"id" => id}) do
    citoyen = Map.get(conn.assigns, :citoyen)

    depute =
      Repo.get!(Depute, id)
      |> set_followed(citoyen)

    render(conn, "show.json", depute: depute)
  end

  def search(conn, %{"query" => query}) do
    citoyen = Map.get(conn.assigns, :citoyen)

    sanitized_query = String.trim(query)

    deputes =
      sanitized_query
      |> Integer.parse
      |> case do
        {code_postal, _} -> [An.DeputeService.get_depute_of_commune(code_postal)]
        :error -> An.DeputeService.search(sanitized_query)
      end
      |> Enum.map(&(set_followed(&1, citoyen)))

    render(conn, "index.json", deputes: deputes)
  end

  defp set_followed(depute, nil), do: Map.put(depute, :followed, false)
  defp set_followed(depute, citoyen) do
    Map.put(depute, :followed, An.FollowService.follow?(citoyen, depute))
  end

end
