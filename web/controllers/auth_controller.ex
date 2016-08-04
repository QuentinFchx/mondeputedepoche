defmodule An.AuthController do
  use An.Web, :controller

  alias An.AuthService
  alias An.FollowService

  def auth(conn, %{"depute_uid" => depute_uid}) do
    {citoyen, auth_token} = AuthService.auth()

    depute = An.Repo.get(An.Depute, depute_uid)
    FollowService.follow(citoyen, depute)

    json(conn, %{token: auth_token})
  end
end
