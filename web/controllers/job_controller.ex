defmodule Tabinin.JobController do
  use Phoenix.Controller

  plug :action

  def list_all(conn, _params) do
    render conn, "jobs.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], jobs:  Nomad.Jobs.all_jobs(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
  end

  def list_job(conn, %{"job_id" => job_id}) do
    render conn, "job_info.html", 
      job: Nomad.Jobs.get_job(Application.get_env(:tabinin, Tabinin.Nomad)[:server], job_id),
      nodes: Nomad.Nodes.node_map(Application.get_env(:tabinin, Tabinin.Nomad)[:server]),
      allocs: Nomad.Alloc.allocs_by_job(Application.get_env(:tabinin, Tabinin.Nomad)[:server], job_id)
  end

  def list_env(conn, %{"alloc_id" => alloc_id}) do
    render conn, "env_info.html", 
      alloc: Nomad.Alloc.get_alloc(Application.get_env(:tabinin, Tabinin.Nomad)[:server], alloc_id)
  end

  def list_container(conn, %{"alloc_id" => alloc_id}) do
    render conn, "container_info.html", 
      alloc: Nomad.Alloc.get_alloc(Application.get_env(:tabinin, Tabinin.Nomad)[:server], alloc_id)
  end

end

