class MonthAthlete < ActiveRecord::Base
  belongs_to :picture, :class=>Comfy::Cms::File
  
  after_commit :clear_cache

  def self.get_latest
    result = Rails.cache.fetch(:aotm, :expires_in => 300) { MonthAthlete.where(:month=>Date.today.month, :year=>Date.today.year).first }
  end
  
  private
  
  def clear_cache
    Rails.cache.delete(:aotm)
  end
end