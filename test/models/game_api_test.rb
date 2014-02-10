require 'test_helper'

class GameAPITest < ActiveSupport::TestCase
  test "should get game online select" do
    from = Date.today.beginning_of_day
    to   = Time.now
    data = GameAPI.game_online_select( from: from, to: to )
    assert_not_nil data
  end
end