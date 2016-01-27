defmodule Nomad.Alloc do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_allocs(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/allocations')
    |> check_call
  end

  def allocs_by_job(cluster_address, job_id) do
    all_allocs(cluster_address)
    |> filter_map("JobID", job_id)
    |> sort_list_of_maps("ModifyIndex")
  end

  def check_call({:ok, data}), do: data
  
  def filter_map(data, field, val)
  when is_list(data) do
    for e <- data, e[field] == val, do: e
  end
  
  def sort_list_of_maps(data, field )
  when is_list(data) do
    Enum.sort_by(data, &(Map.get(&1, field)), &>=/2)
  end

end
