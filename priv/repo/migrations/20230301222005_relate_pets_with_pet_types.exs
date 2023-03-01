defmodule PetClinic.Repo.Migrations.RelatePetsWithPetTypes do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicServer.PetType

  def change do
    alter table("pets") do
      add :type_id, references("pet_types")
    end

    flush()

    query_pets = "select id, type from pets"
    pets = Ecto.Adapters.SQL.query!(Repo, query_pets).rows

    Enum.each(pets, fn [pet_id | [type | _]] ->
      type_id = Repo.one(from ty in PetType, where: ty.name == ^type, select: ty.id)

      query_update = "update pets set type_id = $1::integer where id = $2::integer"
      Ecto.Adapters.SQL.query!(Repo, query_update, [type_id, pet_id])
    end)

    alter table("pets") do
      remove :type
    end

    flush()
  end
end
