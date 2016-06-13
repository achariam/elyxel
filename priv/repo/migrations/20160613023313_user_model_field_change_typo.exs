defmodule Elyxel.Repo.Migrations.UserModelFieldChangeTypo do
  use Ecto.Migration

  def change do
  	rename table(:users), :opt_secret, to: :otp_secret
  end
end
