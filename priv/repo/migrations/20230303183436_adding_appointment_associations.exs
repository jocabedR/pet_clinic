defmodule PetClinic.Repo.Migrations.AddingAppointmentsAssociations do
  use Ecto.Migration

  def change do
    alter table("appointments") do
      add :vet_id, references("vets")
      add :pet_id, references("pets")
      add :appointment_schedule_id, references("appointment_schedules")
    end
  end
end
