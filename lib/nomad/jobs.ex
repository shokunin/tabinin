defmodule Nomad.Jobs do
  require Logger

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_jobs(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/jobs')
    |> check_call
  end

  def get_job(cluster_address, jobname) do
    Nomad.CallApi.fetch(cluster_address, "/v1/job/#{jobname}")
    |> check_call
  end

  def check_call({:ok, data}), do: data
  def check_call({:error, data}) do
    Logger.error "ERROR: #{data}"
  end

end
