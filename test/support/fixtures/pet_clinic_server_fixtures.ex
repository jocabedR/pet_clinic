defmodule PetClinic.PetClinicServerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicServer` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        type: "some type"
      })
      |> PetClinic.PetClinicServer.create_pet()

    pet
  end

  @doc """
  Generate a vet.
  """
  def vet_fixture(attrs \\ %{}) do
    {:ok, vet} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        specialities: "some specialities"
      })
      |> PetClinic.PetClinicServer.create_vet()

    vet
  end

  @doc """
  Generate a owner.
  """
  def owner_fixture(attrs \\ %{}) do
    {:ok, owner} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        phone_num: "some phone_num"
      })
      |> PetClinic.PetClinicServer.create_owner()

    owner
  end

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: "some sex",
        type: "some type"
      })
      |> PetClinic.PetClinicServer.create_pet()

    pet
  end
end
