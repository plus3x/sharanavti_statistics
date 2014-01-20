class Role < ActiveRecord::Base
  def permit?(controller, action)
    @controller = controller
    @action = action
    case title
      when 'admin'
        true
      when 'client'
        request_to controller: [:sessions], action: [:new, :create, :destroy] or
        request_to controller: [:main]
      else
        false
      end
  end
  
  private

    def request_to args={}
      not ( args[:controller].map(&:to_s) & [@controller] ).empty? and
      (not (args[:action].map(&:to_s)     & [@action]     ).empty? rescue true)
    end
end
