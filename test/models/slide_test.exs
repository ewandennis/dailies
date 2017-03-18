defmodule Giflator.SlideTest do
  use Giflator.ModelCase

  alias Giflator.Slide

  @valid_attrs %{url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Slide.changeset(%Slide{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Slide.changeset(%Slide{}, @invalid_attrs)
    refute changeset.valid?
  end
end
