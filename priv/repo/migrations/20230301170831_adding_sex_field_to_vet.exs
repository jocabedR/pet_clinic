defmodule PetClinic.Repo.Migrations.AddingSexFieldToVet do
  use Ecto.Migration

  def change do
    alter table("vets") do
      add :sex, :string
    end
  end
end
