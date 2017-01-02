defmodule Elyxel.WireView do
  use Elyxel.Web, :view
  import Elyxel.Lightning
  import Elyxel.Time

  def simple_url(url) do
   parsed = url |> URI.parse
   parsed.host
  end

  def next_page(page) do
    page + 1
  end

  def markdown(content) do
    content
    |> Earmark.to_html
    |> raw
  end
end
