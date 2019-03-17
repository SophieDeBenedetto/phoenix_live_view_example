defmodule PairWeb.PageController do
  use PairWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _) do
    LiveView.Controller.live_render(conn, PairWeb.GithubDeployView, session: %{})
  end
end
