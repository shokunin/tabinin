defmodule Tabinin.JobController do
  use Phoenix.Controller

  plug :action

  def list_all(conn, _params) do
    render conn, "jobs.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], jobs:  Nomad.Jobs.all_jobs(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
  end


end

