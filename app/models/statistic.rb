class Statistic < ActiveResource::Base
  def self.select(args)
      response = post(:between, from: args[:from], to: args[:to])
      YAML::load(response.body.gsub!(/(\,)(\S)/, "\\1 \\2"))
    rescue
     nil
  end

  def self.new_dot
      dot = get(:new_dot)
      dot['x'] = dot['x'].to_datetime.to_i # for grafic
      dot
    rescue 
      nil
  end
end
