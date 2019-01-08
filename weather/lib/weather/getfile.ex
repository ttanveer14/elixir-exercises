defmodule Weather.Getfile do
  import Weather.TableFormatter, only: [print_table_for_columns: 2]
  def readxml(url) do
    [mapp] = HTTPoison.get(url)
    |> sepbody()
    |> Quinn.parse(%{strip_namespaces: true})
    #list = mapp
    mapp
    |> Map.values()
    |> Enum.at(2)
    |> extractinfo([], [])
    |> parsestr()
    |> prints()
    #%{current_observation: test} = mapp
    #IO.inspect(list)
    #test = mapp |> extractinfo()
    #IO.inspect(mapp)
    #IO.inspect(headers)
    #IO.inspect(values)
  end

  defp sepbody({:ok, %{body: body}}), do: body
  defp sepbody(_), do: :error

  defp extractinfo([], headers, values) do
    {headers, values}
  end
  defp extractinfo([head | tail], headers, values) do
    %{attr: [], name: head1, value: val1 } = head
    extractinfo(tail, [head1 | headers], [val1 | values])
  end


  defp parsestr({headers, values}) do
    headers = headers |> Enum.drop(-3) |> Enum.drop(7)
    values = values |> Enum.drop(-3) |> Enum.drop(7) |> List.flatten()
    recons({headers, values}, [])
  end

  defp prints(tuplist) do
    for {head, value} <- tuplist do
      IO.puts("#{head}: #{value}")
    end
  end

  defp recons({[], []}, tuplist), do: tuplist
  defp recons({[head1 | tail1], [head2 | tail2]}, tuplist) do
    recons({tail1, tail2}, [{head1, head2} | tuplist])
  end
end
