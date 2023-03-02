defmodule PetClinic.PetClinicServer.Vet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vets" do
    field :age, :integer
    field :email, :string
    field :name, :string
    #field :specialities, :string
    field :sex, Ecto.Enum, values: [:male, :female]

    has_many :patients, PetClinic.PetClinicServer.Pet, foreign_key: :preferred_expert_id

    many_to_many :expert_specialities, PetClinic.PetClinicServer.PetType, join_through: PetClinic.PetClinicServer.ExpertSpeciality

    timestamps()
  end

  @doc false
  def changeset(vet, attrs) do
    vet
    |> cast(attrs, [:name, :age, :email, :expert_specialities, :sex])
    |> validate_required([:name, :age, :email, :expert_specialities, :sex])
    |> validate_inclusion(:age, 0..120)
  end
end
