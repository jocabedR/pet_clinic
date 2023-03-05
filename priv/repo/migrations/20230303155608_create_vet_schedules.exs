defmodule PetClinic.Repo.Migrations.CreateVetSchedules do
  use Ecto.Migration

  def change do
    create table(:vet_schedules) do
      add :day_of_week, :integer
      add :start, :time
      add :end, :time

      timestamps()
    end
  end
end
