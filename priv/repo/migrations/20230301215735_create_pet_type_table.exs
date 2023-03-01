defmodule PetClinic.Repo.Migrations.CreatePetTypeTable do
  use Ecto.Migration
  alias PetClinic.Repo
  alias PetClinic.PetClinicServer.PetType

  def change do
    query_types = "select distinct(type) from pets"
    types = Ecto.Adapters.SQL.query!(Repo, query_types).rows |> List.flatten

    create table("pet_types") do
      add :name, :string
      timestamps()
    end

    flush()

    Enum.each(types, fn type ->
      Repo.insert(%PetType{name: type})
    end)

  end
end
