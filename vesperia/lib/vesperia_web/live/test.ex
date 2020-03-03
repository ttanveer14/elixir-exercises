defmodule VesperiaWeb.Live.Test do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Hello World!
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
