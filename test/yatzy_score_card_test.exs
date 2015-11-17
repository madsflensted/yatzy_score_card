defmodule YatzyScoreCardTest do
  use ExUnit.Case
  doctest YatzyScoreCard

  setup do
    {:ok, pid} = YatzyScoreCard.Store.start_link
    {:ok, [pid: pid]}
  end

  test "register valid option", context do
    YatzyScoreCard.register(context[:pid], {:ones, 4})
  end

  test "cannot register unknown option", context do
    assert_raise MatchError, fn -> YatzyScoreCard.register(context[:pid], {:sevens, 4}) end
  end

  test "cannot register option more than once", context do
    YatzyScoreCard.register(context[:pid], {:ones, 4})
    {result, _ } = YatzyScoreCard.register(context[:pid], {:ones, 4})
    assert result == :error
  end

  test "sums all values", context do
    YatzyScoreCard.register(context[:pid], {:ones, 4})
    YatzyScoreCard.register(context[:pid], {:twos, 6})
    YatzyScoreCard.register(context[:pid], {:fives, 15})
    assert 25 == YatzyScoreCard.total(context[:pid])
  end
end
