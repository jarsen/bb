defmodule BB.Repo.Migrations.AddUniqueIndexEmail do
  use Ecto.Migration

  def change do
    unique_index(:users, :email)
  end
end
