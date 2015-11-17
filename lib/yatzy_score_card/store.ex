defmodule YatzyScoreCard.Store do

  def start_link do
    Agent.start_link(fn -> %{} end)
  end
  
  def set(pid, {name, value}) do
      Agent.update(pid, fn state ->
        Map.put(state, name, value)
      end)
  end

  def get(pid, name) do
    Agent.get(pid, fn state ->
      Map.get(state, name)
    end)
  end

end
