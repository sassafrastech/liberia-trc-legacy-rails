class Videoset < ActiveRecord::Base
  has_many(:videos)
  has_one(:cover, :class_name => "Video")
end
