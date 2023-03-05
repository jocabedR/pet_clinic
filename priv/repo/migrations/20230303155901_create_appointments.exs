defmodule PetClinic.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :date, :date

      timestamps()
    end
  end
end
