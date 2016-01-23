defmodule Tabinin.PageController do
  use Tabinin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
