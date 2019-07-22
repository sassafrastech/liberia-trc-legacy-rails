class Transcript < ActiveRecord::Base
  belongs_to(:region)
  
  def self.all_by_date
    find(:all, :order => "isnull(recorded_on), recorded_on")
  end
end
