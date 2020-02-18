class Video < ActiveRecord::Base
  include Visual
  belongs_to(:videoset)
  belongs_to(:hearing_type)
  belongs_to(:region)
  cattr_reader :per_page
  @@per_page = 20

  def self.filter_clause(params)
    args = []
    conds = []

    conds << "videos.videoset_id = ?"
    args << params[:set_id]

    if params[:region] != "any"
      conds << "videos.region_id = ?"
      args << params[:region]
    end

    if params[:month] != "any"
      conds << "year(videos.recorded_on) = ? and month(videos.recorded_on) = ?"
      args += params[:month].split("-")
    end

    if params[:linitial] != "any"
      conds << "substring(trim(videos.speaker_lname),1,1) = ?"
      args << params[:linitial]
    end

    if params[:htype] != "any"
      conds << "videos.hearing_type_id = ?"
      args << params[:htype]
    end

    replace_bind_variables(conds.join(" and "), args)
  end

  def self.paginate_and_filter(page, filter_clause = "1")
    paginate(:page => page, :conditions => [filter_clause], :order => "recorded_on, title")
  end

  def self.months_with_videos(videoset_id)
    connection.select_all("select year(recorded_on) as `year`, month(recorded_on) as `month`
      from videos where recorded_on is not null and videoset_id = '#{videoset_id}'
      group by `year`, `month` order by `year`, `month`")
  end

  def self.last_initials_with_videos(videoset_id)
    connection.select_all("select substring(trim(speaker_lname),1,1) as linitial
      from videos where speaker_lname is not null and videoset_id = '#{videoset_id}'
      group by linitial order by linitial")
  end

  def base_path
    CONF.videos_path
  end
  def extension(version)
    version == "thumbnail" ? "jpg" : "flv"
  end
end
