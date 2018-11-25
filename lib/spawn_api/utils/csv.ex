alias NimbleCSV.RFC4180, as: CSV

defmodule SpawnApi.Utils.CSV do
  def transpose_generated_data(data) do
    (header_data(data) ++ column_data(data))
    |> CSV.dump_to_iodata()
  end

  defp column_data(generated_data) do
    generated_data
    |> Enum.reduce([], fn {k, data_list}, acc -> acc ++ [data_list] end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp header_data(generated_data) do
    headers =
      generated_data
      |> Enum.reduce([], fn {k, _data_list}, acc -> acc ++ [k] end)

    [headers]
  end
end
