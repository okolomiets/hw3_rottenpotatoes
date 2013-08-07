class Movie < ActiveRecord::Base
  def self.all_ratings
    self.select("DISTINCT rating").collect {|p| p.rating}
  end
end
