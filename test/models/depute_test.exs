defmodule An.DeputeTest do
  use An.ModelCase

  alias An.Depute

  @valid_attrs %{date_naissance: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nom: "some content", prenom: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Depute.changeset(%Depute{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Depute.changeset(%Depute{}, @invalid_attrs)
    refute changeset.valid?
  end
end
