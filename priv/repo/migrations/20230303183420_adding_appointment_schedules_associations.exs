defmodule PetClinic.Repo.Migrations.AddingAppointmentSchedulesAssociations do
  use Ecto.Migration

  def change do
    alter table("appointment_schedules") do
      add :vet_schedule_id, references("vet_schedules")
    end
  end
end
