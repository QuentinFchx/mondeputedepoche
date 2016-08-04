defmodule An.TexteLegTest do
  use An.ModelCase

  alias An.TexteLeg

  @valid_attrs %{raw_json: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TexteLeg.changeset(%TexteLeg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TexteLeg.changeset(%TexteLeg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
