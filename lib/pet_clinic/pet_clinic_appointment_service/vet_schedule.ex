defmodule PetClinic.PetClinicAppointmentService.VetSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vet_schedules" do
    field :day_of_week, :integer
    field :end, :time
    field :start, :time

    belongs_to :vet, PetClinic.PetClinicServer.Vet

    timestamps()
  end

  @doc false
  def changeset(vet_schedule, attrs) do
    vet_schedule
    |> cast(attrs, [:day_of_week, :start, :end, :vet_id])
    |> validate_required([:day_of_week, :start, :end, :vet_id])
  end
end
