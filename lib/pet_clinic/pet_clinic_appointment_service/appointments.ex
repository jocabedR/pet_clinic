defmodule PetClinic.PetClinicAppointmentService.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :date, :date

    belongs_to :appointment_schedule, PetClinic.PetClinicAppointmentService.AppointmentSchedule
    belongs_to :vet, PetClinic.PetClinicServer.Vet
    belongs_to :pet, PetClinic.PetClinicServer.Pet

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :appointment_schedule_id, :vet_id, :pet_id])
    |> validate_required([:date, :appointment_schedule_id, :vet_id, :pet_id])
  end
end
