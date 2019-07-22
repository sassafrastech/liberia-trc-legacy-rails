class Region < ActiveRecord::Base
  has_many :videos
  def self.all_by_country_and_name
    find(:all, :order => "country, name")
  end
  def self.with_videos(filter_clause)
    # query
    find(:all, :joins => :videos, :conditions => [filter_clause], :order => "regions.country, regions.name")
  end
  
  def name_and_country
    country == "Liberia" ? name : "#{name}, #{country}"
  end

  def name_with_county
    country == "Liberia" ? "#{name} County" : "#{name}, #{country}"
  end
end
