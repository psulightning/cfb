class Event < ActiveRecord::Base
  scope :descend_date, ->{order(:event_date=>:desc)}
  
  def self.get_latest
    result = Rails.cache.read(:events)
    if result.nil?
      result = Event.where(["event_date>=?",Date.today]).limit(4)
      Rails.cache.write(:events, result, :expires_in=>5.minutes.from_now)
    end
    result
  end
end