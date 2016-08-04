defmodule An.CitoyenFollowTest do
  use An.ModelCase

  alias An.CitoyenFollow

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CitoyenFollow.changeset(%CitoyenFollow{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CitoyenFollow.changeset(%CitoyenFollow{}, @invalid_attrs)
    refute changeset.valid?
  end
end
