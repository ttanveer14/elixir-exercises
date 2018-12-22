defmodule Fakenum do
  # Replacing all?
  def all?([], _func), do: true
  def all?(list, func), do: all?(list, func, true)
  
  def all?([], _func, true), do: true
  def all?([ head | tail ], func, true), do: all?(tail, func, func.(head))
  def all?(_, _, _), do: false

  # Replacing each
  def each([], _func), do: :ok
  def each([ head | tail ], func) do
    IO.puts("#{func.(head)}")
    each(tail, func)
  end

  # Flip Helper Function
  defp flip(oldlist), do: flip(oldlist, [])
  defp flip([], newlist) do
    newlist
  end
  defp flip([ head | tail ], newlist), do: flip(tail, [ head | newlist ])

  # Replacing filter
  def filter([], _func), do: []
  def filter(list, func), do: filter(list, func, [])

  def filter([], _func, new) do
    flip(new)
  end
  def filter([ head | tail ], func, new) do
    if func.(head) do
      filter(tail, func, [ head | new ])
    else
      filter(tail, func, new)
    end
  end

  # Replacing split
  def split([], _), do: {[], []}
  def split(list, num), do: split([], list, num)

  def split(right, left, 0) do
    {flip(right), left}
  end
  def split(right, [], _), do: {flip(right), []}
  def split(right, [ head | tail ], num) do
    split([ head | right ], tail, num - 1)
  end

  # Replacing take
  def take([], _), do: []
  def take(list, num), do: take(list, [], num)

  def take(_old, new, 0), do: flip(new)
  def take([], new, _), do: flip(new)
  def take([ head | tail ], new, num), do: take(tail, [ head | new ], num - 1)
end