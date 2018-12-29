defmodule MyString do
  def asciichk([]), do: IO.puts("Empty string.")
  def asciichk(list) when is_list(list), do: asciichk(list, true)
  def asciichk(_), do: IO.puts("Invalid input.")
  def asciichk([], check), do: check
  def asciichk([ head | tail ], _check) do
    if head in ?\s..?~ do
      asciichk(tail, true)
    else
      false
    end
  end

  def anagram?([], []), do: true
  def anagram?(word1, word2) when is_list(word1) and is_list(word2), do: anagram?(word1, Enum.reverse(word2), true)

  def anagram?([], [], check), do: check
  def anagram?([], _, _), do: false
  def anagram?(_, [], _), do: false
  def anagram?([ head1 | tail1 ], [ head2 | tail2 ], true) do
    if head1 == head2 do
      anagram?(tail1, tail2, true)
    else
      false
    end
  end

  def hardop([]), do: []
  def hardop(list) do
    first = numfind(list, 0)
    second = numfind(backfind(Enum.reverse(list), []), 0)
    oper  = operfind(list)
    hardop(first, second, oper)
  end
  def hardop(first, second, ?+), do: first+second
  def hardop(first, second, ?-), do: first-second
  def hardop(first, second, ?/), do: first/second
  def hardop(first, second, ?*), do: first*second

  defp numfind([ head | tail ], value) when head in '0123456789' do
      numfind(tail, value*10 + (head - ?0))
  end
  defp numfind(_, value), do: value
  defp operfind([ head | tail ]) do
    if head in '+-*/' do
      head
    else
      operfind(tail)
    end
  end
  defp backfind([ head | tail ], new) when head in '0123456789', do: backfind(tail, [head | new ])
  defp backfind(_, new), do: new

  def center(list) do
    max_length = maxlen(list, 0)
    center(list, max_length)
  end
  def center([], _mlength) do end
  def center([ head | tail ], mlength) do
    num = div((mlength + String.length(head)), 2)
    IO.puts(String.pad_leading(head, num))
    center(tail, mlength)
  end

  defp maxlen([], current), do: current
  defp maxlen([ head | tail ], current) do
    if String.length(head) > current do
      maxlen(tail, String.length(head))
    else
      maxlen(tail, current)
    end   
  end
  
  def capitalize_sentences(<<>>), do: <<>>
  def capitalize_sentences(<< head :: binary-size(1), tail :: binary >>), do: capitalize_sentences(tail, String.upcase(head), false)
  def capitalize_sentences(<<>>, new, _), do: String.reverse(new)
  def capitalize_sentences(<< ". ", tail :: binary >>, new, _), do: capitalize_sentences(tail, " ."<> new, true)
  def capitalize_sentences(<< head :: binary-size(1), tail :: binary >>, new, true), do: capitalize_sentences(tail, String.upcase(head)<>new, false)
  def capitalize_sentences(<< head :: binary-size(1), tail :: binary >>, new, _), do: capitalize_sentences(tail, String.downcase(head)<>new, false)

end