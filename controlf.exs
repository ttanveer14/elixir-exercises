defmodule Controlf do
  def fizzbuzz(n), do: fizzbuzz(n, [])
  def fizzbuzz(n, list) when n > 0, do: fizzbuzz(n-1, [ hfizzbuzz(n) | list ])
  def fizzbuzz(_, list), do: list

  defp hfizzbuzz(n) do
    fizzy = [ n, rem(n, 3), rem(n, 5) ]
    case fizzy do
      [ _, 0, 0 ] -> "FizzBuzz"
      [ _, 0, _ ] -> "Fizz"
      [ _, _, 0 ] -> "Buzz"
      [ n, _, _ ] -> n
    end
  end

  def ok!(param) do
    case param do
      { :ok, data } -> data
      _ -> raise "so tired"
    end
  end
end