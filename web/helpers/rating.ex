defmodule Elyxel.Rating do
  @moduledoc """
  Rating Helper
  """
  import Elyxel.Time

  def calculate_rating(pluses, comments, time) do
    comment_weight = 0.2  #Comments carry a little weight
    gravity = 1.5         #Rating decreases much faster for older items if gravity is increased
    amplifier = 10000     #Surfaces buried significant digits

    round(((pluses + (comments * comment_weight) - 1) / (:math.pow(((elapsed(time)/60/60) + 2), gravity))) * amplifier)
  end
end