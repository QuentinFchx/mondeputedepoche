defmodule An.RepresentationService do
  @an_root "http://www.assemblee-nationale.fr"

  def get_link_of_representation(representation) do
    document_uri =
      representation
      |> Map.get("contenu")
      |> Map.get("documentURI")

    @an_root <> document_uri
  end
end
