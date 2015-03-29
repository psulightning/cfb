class Event < ActiveRecord::Base
  scope :descend_date, ->{order(:event_date=>:desc)}
end