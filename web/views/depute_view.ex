defmodule An.DeputeView do
  use An.Web, :view

  def render("index.json", %{deputes: deputes}) do
    %{data: render_many(deputes, An.DeputeView, "depute.json")}
  end

  def render("show.json", %{depute: depute}) do
    %{data: render_one(depute, An.DeputeView, "depute.json")}
  end

  def render("depute.json", %{depute: depute}) do
    json = %{
      id: depute.uid,
      displayName: "#{depute.prenom} #{depute.nom}",
      dateNaissance: depute.date_naissance,
      image: %{
        url: An.DeputeService.get_depute_picture(depute)
      },
      followed: Map.get(depute, :followed, false)
    }

    json = case An.DeputeService.get_parpol_of_depute(depute) do
      nil -> json
      par_pol -> Map.put(json, "partiPolitique", Phoenix.View.render(An.OrganeView, "organe.json", %{organe: par_pol}))
    end

    case An.DeputeService.get_gp_of_depute(depute) do
      nil -> json
      groupe_pol -> Map.put(json, "groupePolitique", Phoenix.View.render(An.OrganeView, "organe.json", %{organe: groupe_pol}))
    end
  end
end
