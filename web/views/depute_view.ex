defmodule An.DeputeView do
  use An.Web, :view

  def render("index.json", %{deputes: deputes}) do
    %{data: render_many(deputes, An.DeputeView, "depute.json")}
  end

  def render("show.json", %{depute: depute}) do
    %{data: render_one(depute, An.DeputeView, "depute.json")}
  end

  def render("depute.json", %{depute: depute}) do
    An.Activity.depute_to_actor(depute)
  end
end
