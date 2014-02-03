class API < ActiveResource::Base
  def self.game_online_select(args)
      response = post( 'stat.online.get', date_from: args[:from], date_to: args[:to] )

      game_online = YAML::load( response.body.gsub!(/(\,)(\S)/, "\\1 \\2") ) # get array form json
    rescue
     nil
  end

  def self.game_online_dot
      response = post( 'stat.online.get', date_from: 1.minutes.ago, date_to: Time.now )

      dots = YAML::load( response.body.gsub!(/(\,)(\S)/, "\\1 \\2") ) # get array form json
      dots.last
    rescue
     nil
  end
end
