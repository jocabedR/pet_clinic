defmodule PetClinic.Repo.Migrations.CreateVets do
  use Ecto.Migration

  def change do
    create table(:vets) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :specialities, :string

      timestamps()
    end
  end
end
