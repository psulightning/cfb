class Event < ActiveRecord::Base
  scope :descend_date, ->{order(:event_date=>:desc)}
  
  def self.get_latest
    result = Rails.cache.fetch(:events, :expires_in => 300) { Event.where(["event_date>=?",Date.today]).limit(4) }
  end
end