defmodule An.QuestionService do
  alias An.Depute
  alias An.Question
  alias An.Repo

  @spec get_question_indexation(Question) :: tuple
  def get_question_indexation(question) do
    indexation =
      question.raw_json
      |> Map.get("indexationAN")

    analyses =
      indexation
      |> Map.get("analyses")
      |> Map.get("analyse")
      |> case do
        l when is_list(l) -> l
        s -> [s]
      end

    rubrique =
      indexation
      |> Map.get("rubrique")

    {rubrique, analyses}
  end

  def interventions_for_question(question) do
    case question.type do
      "QE" -> parse_question_texte(question)
      _ -> question |> get_texte_reponse |> parse_question_html
    end
  end

  def parse_question_texte(question) do
    interventions = []
    interventions
    |> add_intervenant(question |> Repo.preload(:depute) |> Map.get(:depute))
    |> add_content_to_last_intervention(question |> get_texte_question)
    |> add_intervenant(nil)
    |> add_content_to_last_intervention(question |> get_texte_reponse)
  end

  @spec parse_question_html(Question) :: list
  def parse_question_html(question_html) do
    question_html
    |> Floki.parse
    |> interventions_from_html
  end

  @spec get_texte_reponse(Question) :: String.t
  defp get_texte_reponse(question) do
    question.raw_json
    |> Map.get("textesReponse")
    |> case do
      nil -> nil
      reponses -> reponses |> Map.get("texteReponse") |> Map.get("texte")
    end
  end

  defp get_texte_question(question) do
    question.raw_json
    |> Map.get("textesQuestion")
    |> Map.get("texteQuestion")
    |> Map.get("texte")
  end

  defp interventions_from_html(html_tree) do
    html_tree
    |> Enum.reduce([], fn(html_node, interventions) ->
      handle_html_node(html_node, interventions)
    end)
  end

  defp handle_html_node(html_node, interventions) do
    case html_node do
      tuple when is_tuple(tuple) -> case elem(html_node, 0) do
        "p" -> interventions
        "strong" -> add_intervenant(interventions, Floki.text(html_node) |> parse_intervenant)
        "b" -> add_intervenant(interventions, Floki.text(html_node) |> parse_intervenant)
        "i" -> add_content_to_last_intervention(interventions, Floki.text(html_node), "annotation")
        "br" -> add_content_to_last_intervention(interventions, Floki.text(html_node), "format")
        _ -> add_content_to_last_intervention(interventions, Floki.text(html_node))
      end
      txt -> add_content_to_last_intervention(interventions, txt)
    end
  end

  defp add_intervenant(interventions, intervenant) do
    intervention = %{
      intervenant: intervenant,
      parts: []
    }
    interventions ++ [intervention]
  end

  @spec parse_intervenant(String.t) :: Depute
  defp parse_intervenant(intervenant) do
    name =
      ~r/(m\.|mme)?(?<name>.*\b)/iu
      |> Regex.named_captures(intervenant)
      |> Map.get("name")
      |> String.trim
      |> String.replace(<<0x00A0 :: utf8>>, " ")

    case name do
      "le président" -> An.DeputeService.get_president_of_assemblee(An.OrganeService.current_assemblee)
      _ -> Depute |> Depute.find_by_name(name) |> Repo.one
    end
  end

  @spec add_content_to_last_intervention(list, String.t) :: list
  defp add_content_to_last_intervention(interventions, content, type \\ "text") do
    if length(interventions) > 0 do
      part = %{type: type, content: content}
      updated_last_intervention =
        interventions
        |> List.last
        |> add_content(part)
        List.replace_at(interventions, -1, updated_last_intervention)
    else
      interventions
    end
  end

  @spec add_content(map, map) :: map
  defp add_content(intervention, part) do
    Map.put(intervention, :parts, intervention.parts ++ [part])
  end
end
