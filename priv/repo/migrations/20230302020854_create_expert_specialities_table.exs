defmodule PetClinic.Repo.Migrations.CreateExpertSpecialitiesTable do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicServer.Vet
  alias PetClinic.PetClinicServer.PetType
  alias PetClinic.PetClinicServer.ExpertSpeciality

  def change do
    create table("expert_specialities") do
      add :pet_type_id, :integer
      add :vet_id, :integer
      timestamps()
    end
    flush()

    alter table("vets") do
      add :expert_specialities_id, references("expert_specialities")
    end
    flush()

    vet_specialities = Repo.all(from expert in Vet, select: [expert.id, expert.specialities])
    Enum.each(vet_specialities, fn [vet_id | [specialities | _]] ->
      specialities
      |> String.split(", ")
      |> Enum.each(fn speciality ->
        speciality_id = Repo.one(from s in PetType, where: s.name == ^speciality, select: s.id)
        %ExpertSpeciality{vet_id: vet_id, pet_type_id: speciality_id}
        |> Repo.insert()
      end)
    end)

    alter table("vets") do
      remove :specialities
    end
    flush()
  end
end
