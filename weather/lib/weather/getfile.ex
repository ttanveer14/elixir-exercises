defmodule Weather.Getfile do
  def readxml(url) do
    tup = HTTPoison.get(url)
    tup |> sepbody()
  end

  defp sepbody({:ok, body}), do: body
  defp sepbody({body, _head}), do: body
  defp sepbody({_message, _body}), do: :error
end
