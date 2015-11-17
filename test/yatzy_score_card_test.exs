defmodule YatzyScoreCardTest do
  use ExUnit.Case
  doctest YatzyScoreCard

  setup do
    {:ok, pid} = YatzyScoreCard.Store.start_link
    {:ok, [pid: pid]}
  end

  test "set and get score", context do
    YatzyScoreCard.Store.set(context[:pid], {:ones, 4})
    assert 4 == YatzyScoreCard.Store.get(context[:pid], :ones)
  end
end
