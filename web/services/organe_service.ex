defmodule An.OrganeService do
  import Ecto.Query

  alias An.Organe
  alias An.Repo

  def current_assemblee do
    # FIXME: use viMoDe.dateFin in raw_json
    Organe
    |> where([o], o.code_type == "ASSEMBLEE")
    |> last
    |> Repo.one
  end
end
