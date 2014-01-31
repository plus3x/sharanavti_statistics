class Statistic < ActiveResource::Base
  def self.select(args)
      response = post(:between, from: args[:from], to: args[:to])
      YAML::load( response.body.gsub!(/(\,)(\S)/, "\\1 \\2") ) # get array form json
    rescue
     nil
  end

  def self.new_dot
    get(:new_dot) rescue nil
  end
end
