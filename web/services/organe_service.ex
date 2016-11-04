defmodule An.OrganeService do
  import Ecto.Query

  alias An.Organe
  alias An.Repo

  def current_assemblee do
    Organe
    |> where([o], o.code_type == "ASSEMBLEE")
    |> last
    |> Repo.one
  end
end
