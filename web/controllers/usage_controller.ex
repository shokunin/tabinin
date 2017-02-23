defmodule Tabinin.UsageController do
  use Phoenix.Controller

  plug :action

  def show_usage(conn, _params) do
    all_nodes = Nomad.Nodes.node_infos(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
    render conn, "usage.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], nodes: all_nodes
  end

end
