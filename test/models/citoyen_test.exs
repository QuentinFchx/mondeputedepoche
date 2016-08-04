defmodule An.CitoyenTest do
  use An.ModelCase

  alias An.Citoyen

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Citoyen.changeset(%Citoyen{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Citoyen.changeset(%Citoyen{}, @invalid_attrs)
    refute changeset.valid?
  end
end
