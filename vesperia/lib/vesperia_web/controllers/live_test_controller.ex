defmodule VesperiaWeb.LiveTestController do
  use VesperiaWeb, :controller

  def index(conn, _params) do
    live_render(conn, VesperiaWeb.Live.Test, session: %{})
  end
end
