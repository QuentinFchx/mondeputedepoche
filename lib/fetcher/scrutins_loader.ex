defmodule An.Fetcher.ScrutinsLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Scrutin
  alias An.ScrutinDeputeVote
  alias An.Repo

  @url "LOI/scrutins/Scrutins_XIV.json.zip"

  @types_map %{
    "pours": "pour",
    "contres": "contre",
    "nonVotants": "non_votant",
    "abstentions": "abstention"
  }

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    resource_path
    |> An.Fetcher.AbstractLoader.unzip
    |> Map.get("scrutins")
    |> Map.get("scrutin")
    |> Enum.each(fn(scrutin) -> handle_scrutin(scrutin) end)
  end

  defp handle_scrutin(scrutin_data) do
    date_scrutin = scrutin_data
      |> Map.get("dateScrutin")
      |> An.Fetcher.AbstractLoader.parse_date

    scrutin = %Scrutin{
      uid: scrutin_data |> Map.get("uid"),
      titre: scrutin_data |> Map.get("titre"),
      published_at: date_scrutin,
      sort: scrutin_data |> Map.get("sort") |> Map.get("code"),
      raw_json: scrutin_data |> Map.delete("ventilationVotes")
    }

    scrutin = case Repo.get_by(Scrutin, uid: scrutin.uid) do
      nil  -> scrutin
      scrutin -> scrutin
    end
    |> Scrutin.changeset
    |> Repo.insert_or_update!

    scrutin_data
    |> Map.get("ventilationVotes")
    |> Map.get("organe")
    |> Map.get("groupes")
    |> Map.get("groupe")
    |> Enum.each(fn(groupe) -> handle_groupe_votes(groupe, scrutin) end)
  end

  defp handle_groupe_votes(groupe, scrutin) do
    votes =
      groupe
      |> Map.get("vote")
      |> Map.get("decompteNominatif")

    ["pours", "contres", "nonVotants", "abstentions"]
    |> Enum.each(fn(type) -> handle_type_for_votes(type, votes, scrutin) end)
  end

  defp handle_type_for_votes(type, votes, scrutin) do
    votants = votes |> Map.get(type)
    if is_map(votants) do
      type = Map.get(@types_map, String.to_atom(type))
      case votants |> Map.get("votant") do
        l when is_list(l) -> l
        single -> [single]
      end
      |> Enum.each(fn(vote) -> handle_vote(vote, type, scrutin) end)
    end
  end

  defp handle_vote(vote_data, type, scrutin) do
    vote = %ScrutinDeputeVote{
      depute_uid: vote_data |> Map.get("acteurRef"),
      scrutin_uid: scrutin.uid,
      type: type
    }

    case Repo.get(An.Depute, vote.depute_uid) do
      nil -> nil
      _ -> insert_vote(vote)
    end
  end

  defp insert_vote(vote) do
    case Repo.get_by(ScrutinDeputeVote, Map.take(vote, [:depute_uid, :scrutin_uid])) do
      nil -> Repo.insert!(vote)
      _ -> nil
    end
  end
end
