defmodule Nomad.Nodes do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_nodes(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/nodes')
  end

  def get_node(cluster_address, nodename) do
    Nomad.CallApi.fetch(cluster_address, "/v1/node/#{nodename}")
  end

end
