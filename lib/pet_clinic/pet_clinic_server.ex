defmodule PetClinic.PetClinicServer do
  @moduledoc """
  The PetClinicServer context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetClinicServer.Pet

  @doc """
  Returns the list of pets.

  ## Examples

      iex> list_pets()
      [%Pet{}, ...]

  """
  def list_pets do
    Repo.all(Pet) |> Repo.preload(:type)
  end

  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id), do: Repo.get!(Pet, id) |> Repo.preload(:type)

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%Pet{} = pet, attrs) do
    pet
    |> Pet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pet.

  ## Examples

      iex> delete_pet(pet)
      {:ok, %Pet{}}

      iex> delete_pet(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet(%Pet{} = pet) do
    Repo.delete(pet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet changes.

  ## Examples

      iex> change_pet(pet)
      %Ecto.Changeset{data: %Pet{}}

  """
  def change_pet(%Pet{} = pet, attrs \\ %{}) do
    Pet.changeset(pet, attrs)
  end

  alias PetClinic.PetClinicServer.Vet

  @doc """
  Returns the list of vets.

  ## Examples

      iex> list_vets()
      [%Vet{}, ...]

  """
  def list_vets do
    Repo.all(Vet) |> Repo.preload(:expert_specialities)
  end

  @doc """
  Gets a single vet.

  Raises `Ecto.NoResultsError` if the Vet does not exist.

  ## Examples

      iex> get_vet!(123)
      %Vet{}

      iex> get_vet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vet!(id), do: Repo.get!(Vet, id) |> Repo.preload(:expert_specialities)

  @doc """
  Creates a vet.

  ## Examples

      iex> create_vet(%{field: value})
      {:ok, %Vet{}}

      iex> create_vet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vet(attrs \\ %{}) do
    %Vet{}
    |> Vet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vet.

  ## Examples

      iex> update_vet(vet, %{field: new_value})
      {:ok, %Vet{}}

      iex> update_vet(vet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vet(%Vet{} = vet, attrs) do
    vet
    |> Vet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vet.

  ## Examples

      iex> delete_vet(vet)
      {:ok, %Vet{}}

      iex> delete_vet(vet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vet(%Vet{} = vet) do
    Repo.delete(vet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vet changes.

  ## Examples

      iex> change_vet(vet)
      %Ecto.Changeset{data: %Vet{}}

  """
  def change_vet(%Vet{} = vet, attrs \\ %{}) do
    Vet.changeset(vet, attrs)
  end

  alias PetClinic.PetClinicServer.Owner

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners()
      [%Owner{}, ...]

  """
  def list_owners do
    Repo.all(Owner)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123)
      %Owner{}

      iex> get_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id), do: Repo.get!(Owner, id)

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs \\ %{}) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs) do
    owner
    |> Owner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a owner.

  ## Examples

      iex> delete_owner(owner)
      {:ok, %Owner{}}

      iex> delete_owner(owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner) do
    Repo.delete(owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{data: %Owner{}}

  """
  def change_owner(%Owner{} = owner, attrs \\ %{}) do
    Owner.changeset(owner, attrs)
  end

  alias PetClinic.PetClinicServer.PetType

  def list_pet_types do
    Repo.all(PetType)
  end
end
