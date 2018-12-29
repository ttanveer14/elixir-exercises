defmodule Shipp do
  # tax_rates = [ NC: 0.075, TX: 0.08 ]
  # orders = [
  #   [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  #   [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  #   [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  #   [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  #   [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  #   [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  #   [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  #   [ id: 130, ship_to: :NC, net_amount: 50.00 ] ]

  def sad(orders, [NC: nctax, TX: txtax]) do
    for [id: a, ship_to: b, net_amount: c] <- orders, do: supersad(a, b, c, nctax, txtax)
  end
  defp supersad(id, :NC, amount, nctax, _txtax) do
    [id: id, ship_to: :NC, net_amount: amount, total_amount: amount*(1+nctax)]
  end
  defp supersad(id, :TX, amount, _nctax, txtax) do
    [id: id, ship_to: :TX, net_amount: amount, total_amount: amount*(1+txtax)]
  end
  defp supersad(id, shipto, amount, _nctax, _txtax) do
    [id: id, ship_to: shipto, net_amount: amount, total_amount: amount]
  end

  def sadfile(filename, tax_rates) do
    {:ok, filedev} = File.open(filename)
    filestream = IO.stream(filedev, :line)
    keys = keymatch(Enum.take(filestream, 1))
    firstline = formatt(Enum.take(filestream, 1), keys)
    orders = Enum.reverse(addline(filestream, keys, [firstline]))
    File.close(filedev)
    sad(orders, tax_rates)
  end

  defp formatt([string], keys) do 
    [a, b, c] = String.split(String.trim_trailing(string), ", ")
    d = {Enum.at(keys, 0), stonum(a, 0)}
    e = {Enum.at(keys, 1), String.to_atom(String.trim_leading(b, ":"))}
    f = {Enum.at(keys, 2), stonum(c, 0)}
    [d, e, f]
  end
  defp formatt([], _), do: IO.puts("List is empty!")

  defp addline(filestream, keys, orders) do
    line = Enum.take(filestream, 1)
    if line == [] do
      orders
    else
      addline(filestream, keys, [ formatt(line, keys) | orders ])
    end
  end

  defp stonum(<< head :: utf8, tail :: binary >>, value) when head in 48..57, do: stonum(tail, 10*value + (head - 48))
  defp stonum(<< head :: utf8, tail :: binary >>, value) when head == 46, do: stonum(tail, value, 1)
  defp stonum(<<>>, value), do: value
  defp stonum(<< head :: utf8, tail :: binary >>, value, 1), do: stonum(tail, value + 0.1*(head - 48), 2)
  defp stonum(<< head :: utf8, _ :: binary >>, value, 2), do: value + 0.01*(head - 48)

  defp keymatch([string]) do
    Enum.map(String.split(String.trim_trailing(string), ", "), &String.to_atom(&1))
  end

end