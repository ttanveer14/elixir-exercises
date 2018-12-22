defmodule MyList do
  def square([]), do: []
  def square([head|tail]), do: [ head*head | square(tail)]

  def map([], _func), do: []
  def map([head|tail], func), do: [ func.(head) | map(tail, func) ] 

  def reduce([], value, _fun), do: value
  def reduce([ head | tail ], value, fun), do: reduce(tail, fun.(head, value), fun)

  def mapsum([], _fun), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  def maxnow([], value), do: value
  def maxnow([ headnow | tailnow ], value) when headnow > value do
    maxnow(tailnow, headnow)
  end
  def maxnow([ _headnow | tailnow ], value), do: maxnow(tailnow, value)
  # maxnow.(tail, head)
  def max([]), do: 0
  def max([ head | tail ]) do
    maxnow(tail, head)
  end

  def caesar([], _n), do: []
  def caesar([ head | tail ], n) when head + n <= 122, do: [ head + n | caesar(tail, n) ]
  def caesar([ head | tail ], n) do
    nprime = head + n - 122
    [ nprime | caesar(tail, n) ]
  end

  def span(from, to) when from > to, do: IO.puts("Invalid range input.")
  def span(from, to), do: span(from, to, [])
  def span(from, to, []), do: span(from, to - 1, [to])
  def span(from, to, list) when from <= to, do: span(from, to - 1, [to | list])
  def span(_, _, list), do: list

  # def primefind(n) when n > 2 do
  #   notprime = for factors <- span(2, n-1), rem(n, factors) == 0, do: factors
  #   if notprime == [] do
  #     primefind(n-1) ++ [n]
  #   else
  #     primefind(n-1)
  #   end
  # end
  # def primefind(2), do: [2]
  # def primefind(_), do: []

  def primefind(n) when n >= 2, do: primef(n, [])
  def primefind(_), do: []

  defp primef(n, primes) when n > 2 do
    notprime = for factors <- span(2, n-1), rem(n, factors) == 0, do: factors
    if notprime == [] do
      primef(n-1, [n | primes])
    else
      primef(n-1, primes)
    end
  end
  defp primef(2, primes), do: [2 | primes]

end