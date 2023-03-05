defmodule PetClinic.Repo.Migrations.AddingVetSchedulesAssociations do
  use Ecto.Migration

  def change do
    alter table("vet_schedules") do
      add :vet_id, references("vets")
    end
  end
end
