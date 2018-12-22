defmodule Chop do 
  def guessnow(actual, first..last, -1) do
    current = div(last, 2)
    IO.puts("Is it #{current}")
    guessnow(actual, first..last, current)
  end
  def guessnow(actual, _, actual) do
    actual
  end
  def guessnow(actual, first..last, current) when actual > current do
    first = current + 1
    current = first + div(last-first, 2)
    IO.puts("Is it #{current}")
    guessnow(actual, first..last, current)
  end
  def guessnow(actual, first..last, current) when actual < current do
    last = current - 1
    current = first + div(last - first, 2)
    IO.puts("Is it #{current}")
    guessnow(actual, first..last, current)
  end
  def guess(actual, first..last) when actual > 0 and first < last and actual >= first and actual <= last do
    guessnow(actual, first..last, -1)
  end
  def guess(_, _) do
    IO.puts("Inputs are invalid!")
  end
end