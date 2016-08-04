defmodule An.ScrutinTest do
  use An.ModelCase

  alias An.Scrutin

  @valid_attrs %{titre: "some content", uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Scrutin.changeset(%Scrutin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Scrutin.changeset(%Scrutin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
