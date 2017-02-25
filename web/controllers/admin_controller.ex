defmodule Tabinin.AdminController do
  use Phoenix.Controller

  plug :action

  def show_all(conn, _params) do
    render conn, "admin.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name]
  end

  def gc(conn, _params) do
    res = Nomad.Admin.gc(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
    render conn, "admin_res.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], res: res, admin_action: "Garbage Collection"
  end

  def get_leader(conn, _params) do
    res = Nomad.Admin.leader(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
    render conn, "admin_res.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], res: res, admin_action: "Cluster Leader"
  end

end
