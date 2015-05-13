class MonthAthlete < ActiveRecord::Base
  belongs_to :picture, :class=>Comfy::Cms::File
  
  after_commit :clear_cache

  def self.get_latest
    result = Rails.cache.read(:aotm)
    if result.nil?
      result = MonthAthlete.where(:month=>Date.today.month, :year=>Date.today.year).first
      Rails.cache.write(:aotm, result, :expires_in=>5.minutes.from_now)
    end
    result
  end
  
  private
  
  def clear_cache
    Rails.cache.delete(:aotm)
  end
end