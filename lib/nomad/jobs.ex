defmodule Nomad.Jobs do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_jobs(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/jobs')
    |> check_call
    |> map_element_to_list("ID")
  end

  def get_job(cluster_address, jobname) do
    Nomad.CallApi.fetch(cluster_address, "/v1/job/#{jobname}")
  end

  def check_call({:ok, data}), do: data

  def map_element_to_list(data, field)
  when is_list(data) do
    for e <- data, into: [], do: Map.get(e, field)
  end


end
