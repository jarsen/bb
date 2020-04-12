defmodule BB.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :encrypted_password, :string, null: false
      add :confirmed_at, :naive_datetime

      timestamps()
    end

    unique_index(:users, :email)

    create table(:user_tokens) do
       add :user_id, references(:users, on_delete: :delete_all), null: false
       add :hashed_token, :binary, null: false
       add :context, :string, null: false
       add :sent_to, :string
       add :inserted_at, :naive_datetime
    end
  end
end
