defmodule YatzyScoreCard.Store do

  def start_link do
    Agent.start_link(fn -> {%{}, 0} end)
  end
  
  def set(pid, {name, value}) do
      Agent.get_and_update(pid, fn {scores, total} = state ->
        case Dict.has_key?(scores, name) do
          true -> 
            {{:error, "already taken"}, state}

          false -> {{:ok}, {Dict.put(scores, name, value), total + value}}
        end
      end)
  end

  def get(pid, name) do
    Agent.get(pid, fn {scores, total} ->
      Dict.get(scores, name)
    end)
  end

  def get_total(pid) do
    Agent.get(pid, fn {_, total} ->
      total
    end)
  end

end
