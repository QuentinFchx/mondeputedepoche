defmodule An.MandatTest do
  use An.ModelCase

  alias An.Mandat

  @valid_attrs %{uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Mandat.changeset(%Mandat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Mandat.changeset(%Mandat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
