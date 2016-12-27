defmodule Elyxel.WireView do
  use Elyxel.Web, :view
  import Elyxel.Lightning
  import Elyxel.Time

  def simple_time(time) do

  	seconds = elapsed(time)

  	cond do
  		seconds <= 60 ->
  			"#{seconds}s"
  		seconds < (60 * 60) ->
  			"#{ round(seconds / 60.0) }m"
  		seconds < (60 * 60 * 48) ->
  			"#{ round(seconds / 60.0 / 60.0) }h"
  		seconds < (60 * 60 * 24 * 30) ->
  			"#{ round(seconds / 60.0 / 60.0 / 24.0) }d"
  		seconds < (60 * 60 * 24 * 365) ->
  			"#{ round(seconds / 60.0 / 60.0 / 24.0 / 30.0) }mo"
			true ->
  			"#{ round(seconds / 60.0 / 60.0 / 24.0 / 365.0) }y"
  	end
  end

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
