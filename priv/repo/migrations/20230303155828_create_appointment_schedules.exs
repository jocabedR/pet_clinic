defmodule PetClinic.Repo.Migrations.CreateAppointmentSchedules do
  use Ecto.Migration

  def change do
    create table(:appointment_schedules) do
      add :start, :time
      add :end, :time

      timestamps()
    end
  end
end
