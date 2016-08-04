defmodule An.ScrutinService do
  def get_vote_synthese(scrutin) do
    synthese_vote =
      scrutin.raw_json
      |> Map.get("syntheseVote")

    # Parse strings into numbers
    synthese_vote =
      synthese_vote
      |> Map.update!("decompte", fn(decompte) ->
        ["pour", "contre", "nonVotant", "abstention"]
        |> Enum.reduce(decompte, fn(key, decompte) -> get_and_parse_integer(decompte, key) end)
      end)

    synthese_vote =
      ["nombreVotants", "suffragesExprimes", "nbrSuffragesRequis"]
      |> Enum.reduce(synthese_vote, fn(key, synthese) -> get_and_parse_integer(synthese, key) end)

    synthese_vote
  end

  defp get_and_parse_integer(struct, key) do
    Map.update!(struct, key, fn(value) -> String.to_integer(value) end)
  end
end
