defmodule Elyxel.Time do
  @moduledoc """
  Time Helper
  """

  epoch = {{1970, 1, 1}, {0, 0, 0}}
  @epoch :calendar.datetime_to_gregorian_seconds(epoch)

  def elapsed(time) do
    now = :os.system_time(:seconds)
    past_time =
      time
      |> Ecto.DateTime.to_erl
      |> :calendar.datetime_to_gregorian_seconds
      |> -(@epoch)

    now - past_time
  end

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

end