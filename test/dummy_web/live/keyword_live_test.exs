defmodule DummyWeb.KeywordLiveTest do
  use DummyWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Dummy.Huiyoucai

  @create_attrs %{keyword: "some keyword", pub_date: ~N[2010-04-17 14:00:00], state: "some state"}
  @update_attrs %{
    keyword: "some updated keyword",
    pub_date: ~N[2011-05-18 15:01:01],
    state: "some updated state"
  }
  @invalid_attrs %{keyword: nil, pub_date: nil, state: nil}

  defp fixture(:keyword) do
    {:ok, keyword} = Huiyoucai.create_keyword(@create_attrs)
    keyword
  end

  defp create_keyword(_) do
    keyword = fixture(:keyword)
    %{keyword: keyword}
  end

  describe "Index" do
    setup [:create_keyword]

    test "lists all keywords", %{conn: conn, keyword: keyword} do
      {:ok, _index_live, html} = live(conn, Routes.keyword_index_path(conn, :index))

      assert html =~ "Listing Keywords"
      assert html =~ keyword.keyword
    end

    test "saves new keyword", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.keyword_index_path(conn, :index))

      assert index_live |> element("a", "New Keyword") |> render_click() =~
               "New Keyword"

      assert_patch(index_live, Routes.keyword_index_path(conn, :new))

      assert index_live
             |> form("#keyword-form", keyword: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#keyword-form", keyword: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.keyword_index_path(conn, :index))

      assert html =~ "Keyword created successfully"
      assert html =~ "some keyword"
    end

    test "updates keyword in listing", %{conn: conn, keyword: keyword} do
      {:ok, index_live, _html} = live(conn, Routes.keyword_index_path(conn, :index))

      assert index_live |> element("#keyword-#{keyword.id} a", "Edit") |> render_click() =~
               "Edit Keyword"

      assert_patch(index_live, Routes.keyword_index_path(conn, :edit, keyword))

      assert index_live
             |> form("#keyword-form", keyword: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#keyword-form", keyword: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.keyword_index_path(conn, :index))

      assert html =~ "Keyword updated successfully"
      assert html =~ "some updated keyword"
    end

    test "deletes keyword in listing", %{conn: conn, keyword: keyword} do
      {:ok, index_live, _html} = live(conn, Routes.keyword_index_path(conn, :index))

      assert index_live |> element("#keyword-#{keyword.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#keyword-#{keyword.id}")
    end
  end

  describe "Show" do
    setup [:create_keyword]

    test "displays keyword", %{conn: conn, keyword: keyword} do
      {:ok, _show_live, html} = live(conn, Routes.keyword_show_path(conn, :show, keyword))

      assert html =~ "Show Keyword"
      assert html =~ keyword.keyword
    end

    test "updates keyword within modal", %{conn: conn, keyword: keyword} do
      {:ok, show_live, _html} = live(conn, Routes.keyword_show_path(conn, :show, keyword))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Keyword"

      assert_patch(show_live, Routes.keyword_show_path(conn, :edit, keyword))

      assert show_live
             |> form("#keyword-form", keyword: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#keyword-form", keyword: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.keyword_show_path(conn, :show, keyword))

      assert html =~ "Keyword updated successfully"
      assert html =~ "some updated keyword"
    end
  end
end
