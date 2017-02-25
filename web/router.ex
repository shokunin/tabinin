defmodule Tabinin.Router do
  use Tabinin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tabinin do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/jobs", JobController, :list_all
    get "/nodes", NodeController, :list_all
    get "/servers", NodeController, :list_servers
    get "/usage", UsageController, :show_usage
    get "/admin", AdminController, :show_all
    get "/admin/gc", AdminController, :gc
    get "/admin/leader", AdminController, :get_leader
    get "/nodes/:node_id", NodeController, :list_node
    get "/jobs/:job_id", JobController, :list_job
    get "/container/:alloc_id", JobController, :list_container
    get "/env/:alloc_id", JobController, :list_env
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tabinin do
  #   pipe_through :api
  # end
end
