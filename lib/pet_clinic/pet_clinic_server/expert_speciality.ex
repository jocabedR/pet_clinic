defmodule PetClinic.PetClinicServer.ExpertSpeciality do
  use Ecto.Schema

  schema "expert_specialities" do

    belongs_to :vet, PetClinic.PetClinicServer.Vet
    belongs_to :pet_type, PetClinic.PetClinicServer.PetType

    timestamps()
  end
end
