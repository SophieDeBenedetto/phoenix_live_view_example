defmodule PairWeb.GithubDeployView do
  use Phoenix.LiveView
  @deployment_steps %{
    "deploy" => %{next_step: "create-org", text: "Creating org"},
    "create-org" => %{next_step: "create-repo", text: "Creating repo"},
    "create-repo" => %{next_step: "push-contents", text: "Pushing contents"},
    "push-contents" => %{next_step: "done", text: "Done!"}
  }
  @topic "deployments"

  def render(assigns) do
    PairWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    PairWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, deploy_step: "Ready!", status: "ready")}
  end

  def handle_event(step, _value, socket) do
    next_step = @deployment_steps[step][:next_step]
    text = @deployment_steps[step][:text]
    state = %{deploy_step: text, status: step}
    PairWeb.Endpoint.broadcast_from(self(), @topic, step, state)
    Process.send_after(self(), next_step, 1000)
    {:noreply, assign(socket, state)}
  end

  def handle_info(%{topic: @topic, payload: state}, socket) do
    IO.puts "HANDLE BROADCAST FOR #{state[:status]}"
    {:noreply, assign(socket, state)}
  end

  def handle_info("done", socket) do
    IO.puts "Done!"
    {:noreply, assign(socket, deploy_step: "Done!", status: "done")}
  end

  def handle_info(step, socket) do
    IO.puts "HANDLE INFO FOR #{step}"
    text = @deployment_steps[step][:text]
    state = %{deploy_step: text, status: step}
    next_step = @deployment_steps[step][:next_step]
    PairWeb.Endpoint.broadcast_from(self(), @topic, step, state)
    Process.send_after(self(), next_step, 1000)
    {:noreply, assign(socket, state)}
  end
end
