defmodule Tabinin.JobController do
  use Phoenix.Controller

  plug :action

  def list_all(conn, _params) do
    alljs = elem(Nomad.Jobs.all_jobs(Application.get_env(:tabinin, Tabinin.Nomad)[:server]), 1)
    jobs = for e <- alljs, into: [], do: Map.get(e, "ID")
    render conn, "jobs.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], jobs: jobs
  end


end

