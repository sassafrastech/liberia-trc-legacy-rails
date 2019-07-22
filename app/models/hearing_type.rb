class HearingType < ActiveRecord::Base
  def self.all_by_name
    find(:all, :order => "name")
  end
end
