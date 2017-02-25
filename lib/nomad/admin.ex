defmodule Nomad.Admin do
  require Logger

  @moduledoc """
  Get job information from the nomad cluster
  """

  def gc(cluster_address) do
    Nomad.CallApi.put(cluster_address, "/v1/system/gc","")
  end

  def leader(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, "/v1/status/leader")
  end

  def check_call({:ok, data}), do: data
  def check_call({:error, data}) do
    Logger.error "ERROR: #{data}"
  end

end
