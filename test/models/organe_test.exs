defmodule An.OrganeTest do
  use An.ModelCase

  alias An.Organe

  @valid_attrs %{code_type: "some content", libelle: "some content", type: "some content", uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Organe.changeset(%Organe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Organe.changeset(%Organe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
