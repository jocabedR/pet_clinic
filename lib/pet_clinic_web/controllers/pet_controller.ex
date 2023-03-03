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
    pet_types = PetClinicServer.list_pet_types()
    owners = PetClinicServer.list_owners()
    vets = PetClinicServer.list_vets()
    render(conn, :new, changeset: changeset, pet_types: pet_types, owners: owners, vets: vets)
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
    vet = PetClinicServer.get_vet!(pet.preferred_expert_id)
    owner = PetClinicServer.get_owner!(pet.owner_id)

    render(conn, :show, pet: pet, owner: owner, vet: vet)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetClinicServer.get_pet!(id)
    changeset = PetClinicServer.change_pet(pet)
    pet_types = PetClinicServer.list_pet_types()
    owners = PetClinicServer.list_owners()
    vets = PetClinicServer.list_vets()
    render(conn, :edit, pet: pet, changeset: changeset, pet_types: pet_types, owners: owners, vets: vets)
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
