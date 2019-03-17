defmodule PairWeb.GithubDeployView do
  use Phoenix.LiveView

  def render(assigns) do
    PairWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, deploy_step: "Ready!", status: "ready")}
  end

  def handle_event("github_deploy", _value, socket) do
    IO.puts "Starting deploy..."
    Process.send_after(self(), :create_org, 1000)
    {:noreply, assign(socket, deploy_step: "Starting deploy...", status: "deploy")}
  end

  def handle_info(:create_org, socket) do
    IO.puts "Creating org..."
    Process.send_after(self(), :create_repo, 1000)
    {:noreply, assign(socket, deploy_step: "Creating GitHub org...", status: "create-org")}
  end

  def handle_info(:create_repo, socket) do
    IO.puts "Creating repo..."
    Process.send_after(self(), :push_contents, 1000)
    {:noreply, assign(socket, deploy_step: "Creating GitHub repo...", status: "create-repo")}
  end

  def handle_info(:push_contents, socket) do
    IO.puts "Pushing contents..."
    Process.send_after(self(), :done, 1000)
    {:noreply, assign(socket, deploy_step: "Pushing to repo...", status: "push-contents")}
  end

  def handle_info(:done, socket) do
    IO.puts "Done!"
    {:noreply, assign(socket, deploy_step: "Done!", status: "done")}
  end
end
