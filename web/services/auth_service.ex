defmodule An.AuthService do
  import Joken

  alias An.Citoyen
  alias An.Repo

  @spec auth() :: {An.Citoyen, String.t}
  def auth do
    citoyen = Repo.insert!(%Citoyen{})
    token = token_for_citoyen(citoyen)
    {citoyen, token}
  end

  @spec verify() :: Joken.Token
  def verify do
    %Joken.Token{}
    |> with_json_module(Poison)
    |> with_validation("iat", &(&1 <= current_time))
    |> with_validation("nbf", &(&1 < current_time))
    |> with_signer(hs256("my_secret"))
  end

  @spec token_for_citoyen(Citoyen) :: String.t
  defp token_for_citoyen(citoyen) do
    %{sub: citoyen.id}
    |> token
    |> with_iat
    |> with_nbf
    |> with_signer(hs256("my_secret"))
    |> sign
    |> get_compact
  end
end
