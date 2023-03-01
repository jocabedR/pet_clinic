defmodule PetClinicWeb.PetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicServer
  alias PetClinic.PetClinicServer.Pet

  def index(conn, _params) do
    pets = PetClinicServer.list_pets()
    render(conn, :index, pets: pets)
  end

  def new(conn, _params) do
    changeset = PetClinicServer.change_pet(%Pet{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"pet" => pet_params}) do
    case PetClinicServer.create_pet(pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet created successfully.")
        |> redirect(to: ~p"/pets/#{pet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = PetClinicServer.get_pet!(id)
    render(conn, :show, pet: pet)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetClinicServer.get_pet!(id)
    changeset = PetClinicServer.change_pet(pet)
    render(conn, :edit, pet: pet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = PetClinicServer.get_pet!(id)

    case PetClinicServer.update_pet(pet, pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet updated successfully.")
        |> redirect(to: ~p"/pets/#{pet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, pet: pet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = PetClinicServer.get_pet!(id)
    {:ok, _pet} = PetClinicServer.delete_pet(pet)

    conn
    |> put_flash(:info, "Pet deleted successfully.")
    |> redirect(to: ~p"/pets")
  end
end
