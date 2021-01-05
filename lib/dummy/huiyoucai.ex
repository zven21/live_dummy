defmodule Dummy.Huiyoucai do
  @moduledoc """
  The Huiyoucai context.
  """

  import Ecto.Query, warn: false
  alias Dummy.Repo

  alias Dummy.Huiyoucai.Keyword

  @doc """
  Returns the list of keywords.

  ## Examples

      iex> list_keywords()
      [%Keyword{}, ...]

  """
  def list_keywords do
    queryable = from q in Keyword, order_by: q.id

    Repo.all(queryable)
  end

  @doc """
  Gets a single keyword.

  Raises `Ecto.NoResultsError` if the Keyword does not exist.

  ## Examples

      iex> get_keyword!(123)
      %Keyword{}

      iex> get_keyword!(456)
      ** (Ecto.NoResultsError)

  """
  def get_keyword!(id), do: Repo.get!(Keyword, id)

  @doc """

  """
  def get_keyword(id), do: Repo.get(Keyword, id)

  @doc """
  Creates a keyword.

  ## Examples

      iex> create_keyword(%{field: value})
      {:ok, %Keyword{}}

      iex> create_keyword(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_keyword(attrs \\ %{}) do
    %Keyword{}
    |> Keyword.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a keyword.

  ## Examples

      iex> update_keyword(keyword, %{field: new_value})
      {:ok, %Keyword{}}


      iex> update_keyword(keyword, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_keyword(%Keyword{} = keyword, attrs) do
    keyword
    |> Keyword.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a keyword.

  ## Examples

      iex> delete_keyword(keyword)
      {:ok, %Keyword{}}

      iex> delete_keyword(keyword)
      {:error, %Ecto.Changeset{}}

  """
  def delete_keyword(%Keyword{} = keyword) do
    Repo.delete(keyword)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking keyword changes.

  ## Examples

      iex> change_keyword(keyword)
      %Ecto.Changeset{data: %Keyword{}}

  """
  def change_keyword(%Keyword{} = keyword, attrs \\ %{}) do
    Keyword.changeset(keyword, attrs)
  end

  @doc """
  改变当前 keyword state 的值
  """
  def keyword_change_state(id) do
    case get_keyword(id) do
      nil ->
        {:ok, nil}

      value ->
        if value.state == "1" do
          update_keyword(value, %{"state" => "0"})
        else
          update_keyword(value, %{"state" => "1"})
        end
    end
  end
end
