defmodule PetClinicWeb.OwnerController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicServer
  alias PetClinic.PetClinicServer.Owner

  def index(conn, _params) do
    owners = PetClinicServer.list_owners()
    render(conn, :index, owners: owners)
  end

  def new(conn, _params) do
    changeset = PetClinicServer.change_owner(%Owner{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"owner" => owner_params}) do
    case PetClinicServer.create_owner(owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner created successfully.")
        |> redirect(to: ~p"/owners/#{owner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = PetClinicServer.get_owner!(id)
    render(conn, :show, owner: owner)
  end

  def edit(conn, %{"id" => id}) do
    owner = PetClinicServer.get_owner!(id)
    changeset = PetClinicServer.change_owner(owner)
    render(conn, :edit, owner: owner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = PetClinicServer.get_owner!(id)

    case PetClinicServer.update_owner(owner, owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner updated successfully.")
        |> redirect(to: ~p"/owners/#{owner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, owner: owner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = PetClinicServer.get_owner!(id)
    {:ok, _owner} = PetClinicServer.delete_owner(owner)

    conn
    |> put_flash(:info, "Owner deleted successfully.")
    |> redirect(to: ~p"/owners")
  end
end
