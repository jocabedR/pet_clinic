defmodule PetClinicWeb.PetControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicServerFixtures

  @create_attrs %{age: 42, name: "some name", sex: "some sex", type: "some type"}
  @update_attrs %{age: 43, name: "some updated name", sex: "some updated sex", type: "some updated type"}
  @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

  describe "index" do
    test "lists all pets", %{conn: conn} do
      conn = get(conn, ~p"/pets")
      assert html_response(conn, 200) =~ "Listing Pets"
    end
  end

  describe "new pet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/pets/new")
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "create pet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/pets", pet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/pets/#{id}"

      conn = get(conn, ~p"/pets/#{id}")
      assert html_response(conn, 200) =~ "Pet #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/pets", pet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "edit pet" do
    setup [:create_pet]

    test "renders form for editing chosen pet", %{conn: conn, pet: pet} do
      conn = get(conn, ~p"/pets/#{pet}/edit")
      assert html_response(conn, 200) =~ "Edit Pet"
    end
  end

  describe "update pet" do
    setup [:create_pet]

    test "redirects when data is valid", %{conn: conn, pet: pet} do
      conn = put(conn, ~p"/pets/#{pet}", pet: @update_attrs)
      assert redirected_to(conn) == ~p"/pets/#{pet}"

      conn = get(conn, ~p"/pets/#{pet}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pet: pet} do
      conn = put(conn, ~p"/pets/#{pet}", pet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pet"
    end
  end

  describe "delete pet" do
    setup [:create_pet]

    test "deletes chosen pet", %{conn: conn, pet: pet} do
      conn = delete(conn, ~p"/pets/#{pet}")
      assert redirected_to(conn) == ~p"/pets"

      assert_error_sent 404, fn ->
        get(conn, ~p"/pets/#{pet}")
      end
    end
  end

  defp create_pet(_) do
    pet = pet_fixture()
    %{pet: pet}
  end
end
