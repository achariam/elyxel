defmodule Elyxel.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :role, :string
      add :confirmed_at, :datetime
      add :confirmation_token, :string
      add :confirmation_sent_at, :datetime
      add :reset_token, :string
      add :reset_sent_at, :datetime
      add :otp_required, :boolean, default: false
      add :opt_secret, :string

      timestamps
    end

    create unique_index :users, [:email]
    create unique_index :users, [:username]

  end
end
