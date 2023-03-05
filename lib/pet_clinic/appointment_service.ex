defmodule PetClinic.AppointmentService do
  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetClinicAppointmentService.Appointment
  alias PetClinic.PetClinicAppointmentService.AppointmentSchedule
  alias PetClinic.PetClinicAppointmentService.VetSchedule

  def create_appointment_schedule(attrs \\ %{}) do
    %AppointmentSchedule{}
    |> AppointmentSchedule.changeset(attrs)
    |> Repo.insert()
  end

  def create_vet_schedule(attrs \\ %{}) do
    %VetSchedule{}
    |> VetSchedule.changeset(attrs)
    |> Repo.insert()
  end

  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  ## Vet schedule slots(appointment_schedule)
  def new_vet_schedules(vet_id, day_week, star_time, end_time) do
    {:ok, vet_schedule} = create_vet_schedule(%{vet_id: vet_id, day_of_week: day_week, start: star_time, end: end_time})
    %{vet_schedule => new_appointment_schedules(vet_schedule.id, star_time, end_time, [])}
  end

  def new_appointment_schedules(vet_schedule_id, start_time, end_time, time_list) do
    if start_time == end_time do
      time_list
    else
      {:ok, a_schedule} = create_appointment_schedule(%{vet_schedule_id: vet_schedule_id, start: start_time, end: Time.add(start_time, 30, :minute)})
      new_appointment_schedules(vet_schedule_id, Time.add(start_time, 30, :minute), end_time, time_list ++ [a_schedule])
    end
  end

  ## Consult available schedules
  def get_vet_appointments(vet_id, date) do
    Repo.all(
      from a in Appointment,
      where: a.vet_id == ^vet_id and a.date == ^date,
      select: a.appointment_schedule_id
    )
  end

  def get_available_vet_schedules(vet_id, date) do
    unavailable = get_vet_appointments(vet_id, date)
    date_weekday =  Date.day_of_week(date, :sunday)
    Repo.all(
      from a_schedule in AppointmentSchedule,
      join: vs in VetSchedule,
      on: a_schedule.vet_schedule_id == vs.id,
      where: a_schedule.id not in ^unavailable and ^date_weekday == vs.day_of_week,
      select: [a_schedule.id, a_schedule.start]
    )
  end

  def get_vet_availability(vet_id, date_start, date_end) do
    date_range = Date.range(date_start, date_end)
    Enum.map(date_range, fn d ->
      {d, get_available_vet_schedules(vet_id, d)}
    end)
  end

  ## Schedule an appointment
  def schedule_appointment(vet_id, pet_id, date, appointment_schedule_id) do
    appointment_schedule = Repo.get_by(AppointmentSchedule, id: appointment_schedule_id)
    vet_schedule = Repo.get_by(VetSchedule, id: appointment_schedule.vet_schedule_id)

    cond do
      appointment_schedule_id in get_vet_appointments(vet_id, date) -> {:error, "The appointment schedule is unavailable."}
      Date.day_of_week(date, :sunday) != vet_schedule.day_of_week -> {:error, "Date's day of the week, is not the same that appointment schedule day."}
      vet_schedule.vet_id != vet_id -> {:error, "The work schedule don't belongs to the expert."}
      true -> create_appointment(%{vet_id: vet_id, pet_id: pet_id, date: date, appointment_schedule_id: appointment_schedule_id})
    end
  end
end
