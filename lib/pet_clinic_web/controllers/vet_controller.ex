defmodule PetClinicWeb.VetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicServer
  alias PetClinic.PetClinicServer.Vet

  def index(conn, _params) do
    vets = PetClinicServer.list_vets()
    render(conn, :index, vets: vets)
  end

  def new(conn, _params) do
    changeset = PetClinicServer.change_vet(%Vet{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"vet" => vet_params}) do
    case PetClinicServer.create_vet(vet_params) do
      {:ok, vet} ->
        conn
        |> put_flash(:info, "Vet created successfully.")
        |> redirect(to: ~p"/vets/#{vet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vet = PetClinicServer.get_vet!(id)
    render(conn, :show, vet: vet)
  end

  def edit(conn, %{"id" => id}) do
    vet = PetClinicServer.get_vet!(id)
    changeset = PetClinicServer.change_vet(vet)
    pet_types = PetClinicServer.list_pet_types()
    render(conn, :edit, vet: vet, changeset: changeset, pet_types: pet_types)
  end

  def update(conn, %{"id" => id, "vet" => vet_params}) do
    vet = PetClinicServer.get_vet!(id)

    case PetClinicServer.update_vet(vet, vet_params) do
      {:ok, vet} ->
        conn
        |> put_flash(:info, "Vet updated successfully.")
        |> redirect(to: ~p"/vets/#{vet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, vet: vet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vet = PetClinicServer.get_vet!(id)
    {:ok, _vet} = PetClinicServer.delete_vet(vet)

    conn
    |> put_flash(:info, "Vet deleted successfully.")
    |> redirect(to: ~p"/vets")
  end
end
