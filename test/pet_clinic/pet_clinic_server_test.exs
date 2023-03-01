defmodule PetClinic.PetClinicServerTest do
  use PetClinic.DataCase

  alias PetClinic.PetClinicServer

  describe "pets" do
    alias PetClinic.PetClinicServer.Pet

    import PetClinic.PetClinicServerFixtures

    @invalid_attrs %{age: nil, name: nil, type: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetClinicServer.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetClinicServer.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{age: 42, name: "some name", type: "some type"}

      assert {:ok, %Pet{} = pet} = PetClinicServer.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.name == "some name"
      assert pet.type == "some type"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{age: 43, name: "some updated name", type: "some updated type"}

      assert {:ok, %Pet{} = pet} = PetClinicServer.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.name == "some updated name"
      assert pet.type == "some updated type"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.update_pet(pet, @invalid_attrs)
      assert pet == PetClinicServer.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetClinicServer.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicServer.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetClinicServer.change_pet(pet)
    end
  end

  describe "vets" do
    alias PetClinic.PetClinicServer.Vet

    import PetClinic.PetClinicServerFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, specialities: nil}

    test "list_vets/0 returns all vets" do
      vet = vet_fixture()
      assert PetClinicServer.list_vets() == [vet]
    end

    test "get_vet!/1 returns the vet with given id" do
      vet = vet_fixture()
      assert PetClinicServer.get_vet!(vet.id) == vet
    end

    test "create_vet/1 with valid data creates a vet" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", specialities: "some specialities"}

      assert {:ok, %Vet{} = vet} = PetClinicServer.create_vet(valid_attrs)
      assert vet.age == 42
      assert vet.email == "some email"
      assert vet.name == "some name"
      assert vet.specialities == "some specialities"
    end

    test "create_vet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.create_vet(@invalid_attrs)
    end

    test "update_vet/2 with valid data updates the vet" do
      vet = vet_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", specialities: "some updated specialities"}

      assert {:ok, %Vet{} = vet} = PetClinicServer.update_vet(vet, update_attrs)
      assert vet.age == 43
      assert vet.email == "some updated email"
      assert vet.name == "some updated name"
      assert vet.specialities == "some updated specialities"
    end

    test "update_vet/2 with invalid data returns error changeset" do
      vet = vet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.update_vet(vet, @invalid_attrs)
      assert vet == PetClinicServer.get_vet!(vet.id)
    end

    test "delete_vet/1 deletes the vet" do
      vet = vet_fixture()
      assert {:ok, %Vet{}} = PetClinicServer.delete_vet(vet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicServer.get_vet!(vet.id) end
    end

    test "change_vet/1 returns a vet changeset" do
      vet = vet_fixture()
      assert %Ecto.Changeset{} = PetClinicServer.change_vet(vet)
    end
  end

  describe "owners" do
    alias PetClinic.PetClinicServer.Owner

    import PetClinic.PetClinicServerFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

    test "list_owners/0 returns all owners" do
      owner = owner_fixture()
      assert PetClinicServer.list_owners() == [owner]
    end

    test "get_owner!/1 returns the owner with given id" do
      owner = owner_fixture()
      assert PetClinicServer.get_owner!(owner.id) == owner
    end

    test "create_owner/1 with valid data creates a owner" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}

      assert {:ok, %Owner{} = owner} = PetClinicServer.create_owner(valid_attrs)
      assert owner.age == 42
      assert owner.email == "some email"
      assert owner.name == "some name"
      assert owner.phone_num == "some phone_num"
    end

    test "create_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.create_owner(@invalid_attrs)
    end

    test "update_owner/2 with valid data updates the owner" do
      owner = owner_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", phone_num: "some updated phone_num"}

      assert {:ok, %Owner{} = owner} = PetClinicServer.update_owner(owner, update_attrs)
      assert owner.age == 43
      assert owner.email == "some updated email"
      assert owner.name == "some updated name"
      assert owner.phone_num == "some updated phone_num"
    end

    test "update_owner/2 with invalid data returns error changeset" do
      owner = owner_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.update_owner(owner, @invalid_attrs)
      assert owner == PetClinicServer.get_owner!(owner.id)
    end

    test "delete_owner/1 deletes the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{}} = PetClinicServer.delete_owner(owner)
      assert_raise Ecto.NoResultsError, fn -> PetClinicServer.get_owner!(owner.id) end
    end

    test "change_owner/1 returns a owner changeset" do
      owner = owner_fixture()
      assert %Ecto.Changeset{} = PetClinicServer.change_owner(owner)
    end
  end

  describe "pets" do
    alias PetClinic.PetClinicServer.Pet

    import PetClinic.PetClinicServerFixtures

    @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetClinicServer.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetClinicServer.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{age: 42, name: "some name", sex: "some sex", type: "some type"}

      assert {:ok, %Pet{} = pet} = PetClinicServer.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.name == "some name"
      assert pet.sex == "some sex"
      assert pet.type == "some type"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{age: 43, name: "some updated name", sex: "some updated sex", type: "some updated type"}

      assert {:ok, %Pet{} = pet} = PetClinicServer.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.name == "some updated name"
      assert pet.sex == "some updated sex"
      assert pet.type == "some updated type"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicServer.update_pet(pet, @invalid_attrs)
      assert pet == PetClinicServer.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetClinicServer.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicServer.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetClinicServer.change_pet(pet)
    end
  end
end
