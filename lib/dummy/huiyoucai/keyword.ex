defmodule Dummy.Huiyoucai.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  schema "keywords" do
    field :keyword, :string
    field :pub_date, :naive_datetime
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:keyword, :state, :pub_date])
    |> validate_required([:keyword, :state, :pub_date])
  end
end
