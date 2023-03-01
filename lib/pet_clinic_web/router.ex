defmodule PetClinicWeb.Router do
  use PetClinicWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PetClinicWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PetClinicWeb do
    pipe_through :browser

    get "/", PageController, :home

    resources "/pets", PetController

    resources "/vets", VetController

    resources "/owners", OwnerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PetClinicWeb do
  #   pipe_through :api
  # end
end
