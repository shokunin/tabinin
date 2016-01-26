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

  def check_call({:ok, data}), do: data


end
