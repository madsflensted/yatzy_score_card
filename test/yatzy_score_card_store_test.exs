defmodule YatzyScoreCardStoreTest do
  use ExUnit.Case
  doctest YatzyScoreCard

  alias YatzyScoreCard.Store, as: Store

  setup do
    {:ok, pid} = Store.start_link
    {:ok, [pid: pid]}
  end

  test "set and get score", context do
    {:ok} = Store.set(context[:pid], {:ones, 4})
    assert 4 == Store.get(context[:pid], :ones)
  end

  test "cannot overwrite set value", context do
    {:ok} = Store.set(context[:pid], {:ones, 4})
    {:error, "already taken"} = Store.set(context[:pid], {:ones, 1})
    assert 4 == Store.get(context[:pid], :ones)
  end

  test "stores running total", context do
    {:ok} = Store.set(context[:pid], {:ones, 4})
    {:ok} = Store.set(context[:pid], {:threes, 9})
    assert 13 == Store.get_total(context[:pid])
  end
end
