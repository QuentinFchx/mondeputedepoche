defmodule An.Activity do
  defstruct actor: nil, verb: nil, object: nil, published: nil
  # http://activitystrea.ms/specs/json/1.0/#activity

  @spec depute_to_actor(An.Depute) :: struct
  def depute_to_actor(depute) do
    %{
      id: depute.uid,
      objectType: "depute",
      displayName: "#{depute.prenom} #{depute.nom}",
      image: %{
        url: An.DeputeService.get_depute_picture(depute)
      }
    }
  end

  @spec scrutin_to_object(An.Scrutin) :: struct
  def scrutin_to_object(scrutin) do
    %{
      id: scrutin.uid,
      objectType: "scrutin",
      displayName: scrutin.titre,
      sort: scrutin.sort,
      synthese: An.ScrutinService.get_vote_synthese(scrutin)
    }
  end

  @spec vote_to_object(An.DeputeVoteScrutin) :: struct
  def vote_to_object(vote) do
    %{
      objectType: "vote",
      type: vote.type
    }
  end

  def intervention_to_object(intervention) do
    intervenant = case intervention.intervenant do
      %An.Depute{} -> depute_to_actor(intervention.intervenant)
      _ -> intervention.intervenant
    end
    %{
      intervenant: intervenant,
      parts: intervention.parts
    }
  end

  @spec question_to_object(An.Question) :: struct
  def question_to_object(question) do
    interventions =
      An.QuestionService.interventions_for_question(question)
      |> Enum.map(&intervention_to_object(&1))

    indexation = An.QuestionService.get_question_indexation(question)

    %{
      id: question.uid,
      objectType: "question",
      type: question.type,
      interventions: interventions,
      indexation: %{
        rubrique: elem(indexation, 0),
        analyses: elem(indexation, 1)
      }
    }
  end

  def representation_to_object(representation) do
    %{
      objectType: "representation",
      url: An.RepresentationService.get_link_of_representation(representation)
    }
  end

  @spec amendement_to_object(An.Amendement) :: struct
  def amendement_to_object(amendement) do
    representation =
      amendement.raw_json
      |> Map.get("representations")
      |> Map.get("representation")

    # FIXME: sort might be nil
    sort =
      amendement.raw_json
      |> Map.get("sort")
      |> case do
        nil -> nil
        sort -> Map.get(sort, "sortEnSeance")
      end

    %{
      id: amendement.uid,
      objectType: "amendement",
      sort: sort,
      corps: %{
        dispositif: amendement.raw_json |> Map.get("corps") |> Map.get("dispositif")
      },
      attachments: [
        representation_to_object(representation)
      ]
    }
  end
end
