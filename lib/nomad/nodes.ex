defmodule Nomad.Nodes do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_nodes(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/nodes')
    |> check_call
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


  def check_call({:ok, data}), do: data

  def filter_map(data)
  when is_list(data) do
    for v <- data, into: %{}, do: {v["ID"], v["Name"]}
  end




end
