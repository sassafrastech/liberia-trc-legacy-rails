class Photo < ActiveRecord::Base
  include Visual
  belongs_to(:album)
  
  def base_path
    CONF.photos_path
  end
  def extension(version)
    "jpg"
  end
end
