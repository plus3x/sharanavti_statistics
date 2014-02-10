class Chart
  def self.game_online
    from = Date.today.beginning_of_day
    to   = Time.now

    game_online = GameAPI.game_online_select( from: from, to: to ) rescue nil

    return nil unless game_online

    data = []
    game_online.each_with_index { |online, i| data << [ ((from.to_i + i.minutes.to_i) * 1000), (online.nil? ? 0 : online) ] }

    data
  end

  def self.game_online_on_date( date )
    from = date.beginning_of_day
    to   = date.end_of_day

    game_online = GameAPI.game_online_select( from: from, to: to ) rescue nil

    return nil unless game_online

    data = { points: [] }
    game_online.each_with_index { |online, i| data[:points] << [ ((from.to_i + i.minutes.to_i) * 1000), (online.nil? ? 0 : online) ] }

    data[:average] = "%.2f" % "#{(game_online.sum.to_f / game_online.size) rescue 0}"
    data[:max] = game_online.max
    data[:min] = game_online.min

    data
  end

  def self.new_point
    dots = GameAPI.game_online_select( from: 1.minute.ago, to: Time.now ) rescue [0]
    dot = dots.last rescue 0
    { x: ((Time.now.to_i + Time.now.gmt_offset) * 1000), y: dot }
  end
end