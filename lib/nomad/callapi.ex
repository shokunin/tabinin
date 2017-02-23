defmodule Nomad.CallApi do

  require Logger

  @moduledoc """
  Make the actual calls to the NomadAPI
  """

  @user_agent [{"User-agent", "ElixirNomadAPI"}]

  def fetch(cluster_address, path) do
    HTTPoison.start
    get_full_url(cluster_address, path)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def get_full_url(cluster_address, path) do
    Logger.debug "Fetching #{cluster_address}#{path}"
    "#{cluster_address}#{path}"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: {:ok, Poison.Parser.parse!(body)}

  def handle_response({:error, %HTTPoison.Error{reason: error}}), do: {:error, error}

  def handle_response({:ok, %HTTPoison.Response{status_code: status, body: body}})
    when status >= 400 do
      {:error, body}
    end

end
