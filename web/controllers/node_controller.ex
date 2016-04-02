defmodule Tabinin.NodeController do
  use Phoenix.Controller

  plug :action

  def list_all(conn, _params) do
    render conn, "nodes.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], nodes:  Nomad.Nodes.all_nodes(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
  end

  def list_servers(conn, _params) do
    render conn, "servers.html", cluster: Application.get_env(:tabinin, Tabinin.Nomad)[:name], nodes:  Nomad.Nodes.all_servers(Application.get_env(:tabinin, Tabinin.Nomad)[:server])
  end

  def list_node(conn, %{"node_id" => node_id}) do
    render conn, "node_info.html", node: Nomad.Nodes.get_node(Application.get_env(:tabinin, Tabinin.Nomad)[:server], node_id)
  end

end
