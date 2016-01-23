defmodule Nomad.Jobs do

  @moduledoc """
  Get job information from the nomad cluster
  """

  def all_jobs(cluster_address) do
    Nomad.CallApi.fetch(cluster_address, '/v1/jobs')
  end

  def get_job(cluster_address, jobname) do
    Nomad.CallApi.fetch(cluster_address, "/v1/job/#{jobname}")
  end

end
