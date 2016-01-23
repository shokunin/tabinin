defmodule Nomad.Agents do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def get_members(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/agent/members')
  end

  def get_servers(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/agent/servers')
  end

end
