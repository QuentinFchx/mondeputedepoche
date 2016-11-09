defmodule An.DeputeController do
  use An.Web, :controller

  alias An.Depute

  def index(conn, _params) do
    deputes = Repo.all(Depute)
    render(conn, "index.json", deputes: deputes)
  end

  def show(conn, %{"id" => id}) do
    depute = Repo.get!(Depute, id)
    render(conn, "show.json", depute: depute)
  end

  def search(conn, %{"query" => query}) do
    deputes =
      case Integer.parse(query) do
        {code_postal, _} -> [An.DeputeService.get_depute_of_commune(code_postal)]
        :error -> An.DeputeService.search(query)
      end

    render(conn, "index.json", deputes: deputes)
  end
end
