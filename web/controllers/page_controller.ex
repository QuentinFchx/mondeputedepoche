defmodule An.PageController do
  use An.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def an(conn, _params) do
    render conn, "an.html"
  end
end
