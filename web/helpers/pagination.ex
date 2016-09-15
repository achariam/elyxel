defmodule Elyxel.Pagination do
  @moduledoc """
  Generic ecto pagination helper
  """
  import Ecto.Query
  alias Elyxel.Repo

  def page(query, page: page, per_page: per_page) do
    scrub_page = page |> scrub
    count = per_page + 1
    result = query
              |> limit(^count)
              |> offset(^(scrub_page*per_page))
              |> Repo.all
    %{ has_next?: (length(result) == count),
       has_prev?: scrub_page > 0,
       current_page: scrub_page,
       list: Enum.slice(result, 0, count-1) }
  end

  defp scrub(page) do
    cond do
      is_integer(page) && (page >= 0) ->
        page
      is_binary(page) ->
        case Integer.parse(page) do
          {page, _} ->
            if (page < 0) do
              0
            else
              page
            end
          :error -> 0
        end
      true ->
        0
    end
  end
end