defmodule An.DosLegTest do
  use An.ModelCase

  alias An.DosLeg

  @valid_attrs %{raw_json: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DosLeg.changeset(%DosLeg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DosLeg.changeset(%DosLeg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
