defmodule An.AmendementTest do
  use An.ModelCase

  alias An.Amendement

  @valid_attrs %{raw_json: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Amendement.changeset(%Amendement{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Amendement.changeset(%Amendement{}, @invalid_attrs)
    refute changeset.valid?
  end
end
