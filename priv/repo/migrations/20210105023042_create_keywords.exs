defmodule Dummy.Repo.Migrations.CreateKeywords do
  use Ecto.Migration

  def change do
    create table(:keywords) do
      add :keyword, :string
      add :state, :string
      add :pub_date, :naive_datetime

      timestamps()
    end
  end
end
