defmodule SpawnApi.Utils do
  def parse_integer(i) do
    case Integer.parse(i) do
      {integer, _} -> {:ok, integer}
      :error -> {:ok, 10}
    end
  end
end
