defmodule Elyxel.WireView do
  use Elyxel.Web, :view
  import Elyxel.Lightning

  epoch = {{1970, 1, 1}, {0, 0, 0}}
  @epoch :calendar.datetime_to_gregorian_seconds(epoch)

  def simple_time(time) do
  	now = :os.system_time(:seconds)
  	past_time =
	  	time
	  	|> Ecto.DateTime.to_erl
	  	|> :calendar.datetime_to_gregorian_seconds
	  	|> -(@epoch)

  	elapsed = (now - past_time)

  	cond do
  		elapsed <= 60 ->
  			"#{elapsed}s"
  		elapsed < (60 * 60) ->
  			"#{ round(elapsed / 60.0) }m"
  		elapsed < (60 * 60 * 48) ->
  			"#{ round(elapsed / 60.0 / 60.0) }h"
  		elapsed < (60 * 60 * 24 * 30) ->
  			"#{ round(elapsed / 60.0 / 60.0 / 24.0) }d"
  		elapsed < (60 * 60 * 24 * 365) ->
  			"#{ round(elapsed / 60.0 / 60.0 / 24.0 / 30.0) }mo"
			true ->
  			"#{ round(elapsed / 60.0 / 60.0 / 24.0 / 365.0) }y"
  	end
  end

  def simple_url(url) do
   parsed = url |> URI.parse
   parsed.host
  end

  def next_page(page) do
    page + 1
  end
end
