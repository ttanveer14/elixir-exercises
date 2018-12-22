defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)

  def flatten([]), do: []
  def flatten(list) when is_list(list), do: flatten(list, [])
  def flatten(value), do: value

  def flatten([], acc) do
    acc
  end

  def flatten([head | tail], acc) do
    Enum.concat( flatten(head, acc), flatten(tail, acc))
  end

  def flatten(value, acc) do
    [value | acc]
  end
end