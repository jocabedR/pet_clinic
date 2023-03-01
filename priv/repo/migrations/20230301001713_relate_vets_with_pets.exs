defmodule PetClinic.Repo.Migrations.RelateVetsWithPets do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :preferred_expert_id, references("vets")
    end
  end
end
