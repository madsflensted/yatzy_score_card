defmodule YatzyScoreCard.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def start_player(supervisor, name) do
    Supervisor.start_child(supervisor, [name])
  end

  def init(:ok) do
    children = [
      worker(YatzyScoreCard, [], restart: :temporary)
      ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
