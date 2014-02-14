require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  test "should get game online" do
    data = Chart.game_online
    assert_not_nil data
  end

  test "should get game online on date" do
    date = Date.current
    data = Chart.game_online_on_date( date )
    assert_not_nil data
    assert_not_nil data[:points]
    assert_not_nil data[:average]
    assert_not_nil data[:max]
    assert_not_nil data[:min]
  end

  test "should get new point" do
    point = Chart.new_point
    assert_not_nil point[:x]
    assert_not_nil point[:y]
  end
end