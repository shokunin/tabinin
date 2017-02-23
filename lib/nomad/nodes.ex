defmodule Nomad.Nodes do
  require Logger

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_nodes(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/nodes')
    |> check_call
  end

  def all_servers(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/agent/members')
    |> check_call
    |> sort_results("Name")
  end

  def get_node(cluster_address, node_id) do
    Nomad.CallApi.fetch(cluster_address, "/v1/node/#{node_id}")
    |> check_call
  end

  def id_to_name(cluster_address, node_id) do
    Nomad.CallApi.fetch(cluster_address, "/v1/node/#{node_id}")
    |> check_call
    |> Map.get("Name")
  end

  def node_map(cluster_address) do
    all_nodes(cluster_address)
    |> filter_map
  end

  def node_infos(cluster_address) do
    all_nodes(cluster_address)
    |> Enum.map(fn n -> {Map.get(n, "Name"), Map.get(n, "ID")} end )
    |> Enum.map(fn {name, id} -> {name, get_node(cluster_address, id)["Attributes"]["unique.network.ip-address"]} end )
    |> Enum.map(fn {name, ip} -> {name, Nomad.CallApi.fetch("http://#{ip}:4646", "/v1/client/stats")} end )
    |> Enum.map(fn {name, z} -> {name, check_call(z)} end )
  end


  def check_call({:ok, data}), do: data
  def check_call({:error, data}) do
    Logger.error "ERROR: #{data}"
  end

  def filter_map(data)
  when is_list(data) do
    for v <- data, into: %{}, do: {v["ID"], v["Name"]}
  end

  def sort_results(data, field)
  when is_list(data) do
    Enum.sort_by(data, &(Map.get(&1, field)), &>=/2)
  end

  def sort_results(data, field)
  when is_map(data) do
    sort_results(data["Members"], "Name")
  end

end
