defmodule PetClinicWeb.VetControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicServerFixtures

  @create_attrs %{age: 42, email: "some email", name: "some name", specialities: "some specialities"}
  @update_attrs %{age: 43, email: "some updated email", name: "some updated name", specialities: "some updated specialities"}
  @invalid_attrs %{age: nil, email: nil, name: nil, specialities: nil}

  describe "index" do
    test "lists all vets", %{conn: conn} do
      conn = get(conn, ~p"/vets")
      assert html_response(conn, 200) =~ "Listing Vets"
    end
  end

  describe "new vet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/vets/new")
      assert html_response(conn, 200) =~ "New Vet"
    end
  end

  describe "create vet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/vets", vet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/vets/#{id}"

      conn = get(conn, ~p"/vets/#{id}")
      assert html_response(conn, 200) =~ "Vet #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/vets", vet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Vet"
    end
  end

  describe "edit vet" do
    setup [:create_vet]

    test "renders form for editing chosen vet", %{conn: conn, vet: vet} do
      conn = get(conn, ~p"/vets/#{vet}/edit")
      assert html_response(conn, 200) =~ "Edit Vet"
    end
  end

  describe "update vet" do
    setup [:create_vet]

    test "redirects when data is valid", %{conn: conn, vet: vet} do
      conn = put(conn, ~p"/vets/#{vet}", vet: @update_attrs)
      assert redirected_to(conn) == ~p"/vets/#{vet}"

      conn = get(conn, ~p"/vets/#{vet}")
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, vet: vet} do
      conn = put(conn, ~p"/vets/#{vet}", vet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Vet"
    end
  end

  describe "delete vet" do
    setup [:create_vet]

    test "deletes chosen vet", %{conn: conn, vet: vet} do
      conn = delete(conn, ~p"/vets/#{vet}")
      assert redirected_to(conn) == ~p"/vets"

      assert_error_sent 404, fn ->
        get(conn, ~p"/vets/#{vet}")
      end
    end
  end

  defp create_vet(_) do
    vet = vet_fixture()
    %{vet: vet}
  end
end
