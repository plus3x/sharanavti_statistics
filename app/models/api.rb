class API < ActiveResource::Base
  def self.game_online_select(args)
      get 'stat.online.get', date_from: args[:from], date_to: args[:to]
    rescue
     nil
  end

  def self.game_online_dot
      dots = get( 'stat.online.get', date_from: 1.minutes.ago, date_to: Time.now )
      dots.last
    rescue
     nil
  end
end
