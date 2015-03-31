class MonthAthlete < ActiveRecord::Base
  belongs_to :picture, :class=>Comfy::Cms::File

  def self.get_latest
    result = Rails.cache.read(:aotm)
    if result.nil?
      result = MonthAthlete.where(:month=>Date.today.month, :year=>Date.today.year).first
      Rails.cache.write(:aotm, result, :expires=>1.day.from_now)
    end
    result
  end
end