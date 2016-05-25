defmodule Elyxel.PageController do
  use Elyxel.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
