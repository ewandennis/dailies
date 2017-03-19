defmodule Dailies.Repo.Migrations.CreateSlide do
  use Ecto.Migration

  def change do
    create table(:slides) do
      add :url, :string

      timestamps()
    end

  end
end
