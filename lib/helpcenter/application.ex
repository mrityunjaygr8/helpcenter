defmodule Helpcenter.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [Helpcenter.Repo]

    opts = [strategy: :one_for_one, name: Helpcenter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
