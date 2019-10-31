class VideosetsController < ApplicationController

  def index
    @title = "TRC Videos"
    set_crumb([["Videos", videosets_path]])
    @sets = Videoset.all
  end

  def show
    # get videoset
    @set = Videoset.find(params[:id])
    @title = @set.title
    set_crumb([["Videos", videosets_path], @set.title])

    if @set.title.match(/Hearing/)
      filter = {}
      [:region, :month, :linitial, :htype].each { |k| filter[k] = params[k] || "any" }
      filter[:set_id] = @set.id

      filter_clause = Video.filter_clause(filter)
      @videos = Video.paginate_and_filter(params[:page], filter_clause)

      # Filter options
      @regions = Region.all_by_country_and_name
      @months = Video.months_with_videos(@set.id)
      @linitials = Video.last_initials_with_videos(@set.id)
      @htypes = HearingType.all_by_name
    else
      @videos = @set.videos.paginate(:page => 1, :order => "recorded_on, title")
    end
  end
end
