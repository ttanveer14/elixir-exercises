defmodule Chain.GusPeter do
  def picktoken do
    receive do
      {sender, msg} ->
        send sender, {:ok, "#{msg} is a cute bird."}
      picktoken()
    end
  end

  def createbirds do
    gpid = spawn(Chain.GusPeter, :picktoken, [])
    send gpid, {self(), "Gus"}
    ppid = spawn(Chain.GusPeter, :picktoken, [])
    send ppid, {self(), "Peter"}

    receive do
      {:ok, message} ->
        IO.puts message
      end

    receive do
      {:ok, message} ->
        IO.puts message
    end
  end
end
