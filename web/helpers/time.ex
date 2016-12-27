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

end