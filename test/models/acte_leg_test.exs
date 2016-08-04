defmodule An.ActeLegTest do
  use An.ModelCase

  alias An.ActeLeg

  @valid_attrs %{raw_json: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActeLeg.changeset(%ActeLeg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActeLeg.changeset(%ActeLeg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
