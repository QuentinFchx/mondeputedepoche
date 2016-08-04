defmodule An.CommuneTest do
  use An.ModelCase

  alias An.Commune

  @valid_attrs %{code_postal: 42, nom: "some content", numero_circonscription: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Commune.changeset(%Commune{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Commune.changeset(%Commune{}, @invalid_attrs)
    refute changeset.valid?
  end
end
