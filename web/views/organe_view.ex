defmodule An.OrganeView do
  use An.Web, :view

  def render("organe.json", %{organe: organe}) do
    %{
      id: organe.uid,
      code_type: organe.code_type,
      libelle: organe.libelle
    }
  end
end
