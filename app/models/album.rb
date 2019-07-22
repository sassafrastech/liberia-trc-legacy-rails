class Album < ActiveRecord::Base
  has_many(:children, :class_name => "Album", :foreign_key => "parent_id")
  has_many(:photos)
  belongs_to(:parent, :class_name => "Album")
  
  def self.top
    find_all_by_parent_id(nil)
  end
  
  def total_count
    photos.size + children.inject(0){|i,c| i += c.total_count}
  end
  
  def cover
    photos.first || children.first.cover
  end
end
