defmodule An.FollowService do
  alias An.Citoyen
  alias An.CitoyenFollow
  alias An.Depute
  alias An.Repo

  @spec follow(Citoyen, Depute) :: none
  def follow(citoyen, depute) do
    Ecto.build_assoc(citoyen, :citoyen_follows, %{depute: depute})
    |> Repo.insert!
  end

  def follow?(citoyen, depute) do
    CitoyenFollow
    |> Repo.get_by(%{citoyen_uid: citoyen.id, depute_uid: depute.uid})
    |> case do
      nil -> false
      _ -> true
    end
  end

  @spec unfollow(Citoyen, Depute) :: none
  def unfollow(citoyen, depute) do
    CitoyenFollow
    |> Repo.get_by(%{citoyen_uid: citoyen.id, depute_uid: depute.uid})
    |> Repo.delete!
  end
end
