defmodule PetClinic.PetClinicAppointmentService.AppointmentSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointment_schedules" do
    field :end, :time
    field :start, :time

    belongs_to :vet_schedule, PetClinic.PetClinicAppointmentService.VetSchedule

    timestamps()
  end

  @doc false
  def changeset(appointment_schedule, attrs) do
    appointment_schedule
    |> cast(attrs, [:start, :end, :vet_schedule_id])
    |> validate_required([:start, :end, :vet_schedule_id])
  end
end
