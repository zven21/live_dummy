defmodule Dummy.HuiyoucaiTest do
  use Dummy.DataCase

  alias Dummy.Huiyoucai

  describe "keywords" do
    alias Dummy.Huiyoucai.Keyword

    @valid_attrs %{
      keyword: "some keyword",
      pub_date: ~N[2010-04-17 14:00:00],
      state: "some state"
    }
    @update_attrs %{
      keyword: "some updated keyword",
      pub_date: ~N[2011-05-18 15:01:01],
      state: "some updated state"
    }
    @invalid_attrs %{keyword: nil, pub_date: nil, state: nil}

    def keyword_fixture(attrs \\ %{}) do
      {:ok, keyword} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Huiyoucai.create_keyword()

      keyword
    end

    test "list_keywords/0 returns all keywords" do
      keyword = keyword_fixture()
      assert Huiyoucai.list_keywords() == [keyword]
    end

    test "get_keyword!/1 returns the keyword with given id" do
      keyword = keyword_fixture()
      assert Huiyoucai.get_keyword!(keyword.id) == keyword
    end

    test "create_keyword/1 with valid data creates a keyword" do
      assert {:ok, %Keyword{} = keyword} = Huiyoucai.create_keyword(@valid_attrs)
      assert keyword.keyword == "some keyword"
      assert keyword.pub_date == ~N[2010-04-17 14:00:00]
      assert keyword.state == "some state"
    end

    test "create_keyword/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Huiyoucai.create_keyword(@invalid_attrs)
    end

    test "update_keyword/2 with valid data updates the keyword" do
      keyword = keyword_fixture()
      assert {:ok, %Keyword{} = keyword} = Huiyoucai.update_keyword(keyword, @update_attrs)
      assert keyword.keyword == "some updated keyword"
      assert keyword.pub_date == ~N[2011-05-18 15:01:01]
      assert keyword.state == "some updated state"
    end

    test "update_keyword/2 with invalid data returns error changeset" do
      keyword = keyword_fixture()
      assert {:error, %Ecto.Changeset{}} = Huiyoucai.update_keyword(keyword, @invalid_attrs)
      assert keyword == Huiyoucai.get_keyword!(keyword.id)
    end

    test "delete_keyword/1 deletes the keyword" do
      keyword = keyword_fixture()
      assert {:ok, %Keyword{}} = Huiyoucai.delete_keyword(keyword)
      assert_raise Ecto.NoResultsError, fn -> Huiyoucai.get_keyword!(keyword.id) end
    end

    test "change_keyword/1 returns a keyword changeset" do
      keyword = keyword_fixture()
      assert %Ecto.Changeset{} = Huiyoucai.change_keyword(keyword)
    end
  end
end
