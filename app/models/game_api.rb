class GameAPI < ActiveResource::Base
  self.element_name = 'api'
  self.logger = Logger.new("#{Rails.root}/log/game_api_#{Rails.env}.log")

  def self.game_online_select(args)
    get('stat.online.get', date_from: args[:from], date_to: args[:to]) rescue nil
  end
end
