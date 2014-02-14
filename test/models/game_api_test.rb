require 'test_helper'
# require 'active_resource/http_mock'

class GameAPITest < ActiveSupport::TestCase
  setup do
    @from = Date.today.beginning_of_day
    @to   = Time.now

    # @data = []
    # (@from.to_i..@to.to_i).step(1.minutes) { |time| @data << Random.rand(0..100) }

    # ActiveResource::HttpMock.respond_to do |mock|
    #   mock.get "/api/stat.online.get?#{ { date_from: @from, date_to: @to }.to_param }", {}, @data
    # end
  end

  test "should get game online select" do
    data = GameAPI.game_online_select( from: @from, to: @to )
    assert_not_nil data
  end
end
