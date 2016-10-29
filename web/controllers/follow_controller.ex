defmodule An.FollowController do
  use An.Web, :controller

  alias An.FollowService
  alias An.Repo
  alias An.Depute

  def follow(conn, %{"id" => id}) do
    depute = Repo.get(Depute, id)

    Map.get(conn.assigns, :citoyen)
    |> FollowService.follow(depute)

    send_resp(conn, 200, "ok")
  end

  def followed(conn, _params) do
    deputes =
      Map.get(conn.assigns, :citoyen)
      |> Repo.preload(:followed)
      |> Map.get(:followed)

    render(conn, An.DeputeView, "index.json", deputes: deputes)
  end

  def unfollow(conn, %{"id" => id}) do
    depute = Repo.get(Depute, id)

    Map.get(conn.assigns, :citoyen)
    |> FollowService.unfollow(depute)

    send_resp(conn, 200, "ok")
  end
end
