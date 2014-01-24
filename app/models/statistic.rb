class Statistic < ActiveResource::Base
  def self.select(args)
    response = post(:between, from: args[:from], to: args[:to]) rescue nil
    YAML::load(response.body.gsub!(/(\,)(\S)/, "\\1 \\2")) 
  end

  def self.new_dot
    response = get(:new_dot) rescue nil
    response
  end
end
