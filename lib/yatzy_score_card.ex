defmodule YatzyScoreCard do
  alias YatzyScoreCard.Store, as: Store

 @valid_options ~w(ones twos threes fours fives sixes one_pair two_pair three_of_a_kind four_of_a_kind small_straight large_straight full_house chance yatzy)a

  def start_link(name) do
    Store.start_link(name)
  end
  
  def register(player, {option, score}) do
    true = Enum.member?(@valid_options, option)
    Store.set(player, {option, score})
  end

  def total(player) do
    Store.get_total(player)
  end

end
