class VideosetsController < ApplicationController

  def index
    @title = "TRC Videos"
    set_crumb([["Videos", videosets_path]])
    @sets = Videoset.all
  end

  def show
    # get videoset
    @set = Videoset.find(params[:id])
    build_filter_description
    @title = [@set.title, @filter_description].compact.join(" - ")
    set_crumb([["Videos", videosets_path], @set.title])

    if @set.title.match(/Hearing/)
      filter = {}
      [:region, :month, :linitial, :htype].each { |k| filter[k] = params[k] || "any" }
      @any_filters = filter.values.uniq != ["any"]

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

  private

  def build_filter_description
    @region_prompt = "County"
    @month_prompt = "Month"
    @linitial_prompt = "Last Name"
    @htype_prompt = "Hearing Type"

    if params[:region] && params[:region] != "any"
      region = Region.find(params[:region])
      @filter_description = @region_prompt = region.name_and_country
    elsif params[:month]
      year, month = params[:month].split("-")
      month = Date::MONTHNAMES[month.to_i]
      @filter_description = @month_prompt = "#{month} #{year}"
    elsif params[:linitial]
      @filter_description = @linitial_prompt = "Last Name '#{params[:linitial].upcase}'"
    elsif params[:htype]
      htype = HearingType.find(params[:htype])
      @filter_description = @htype_prompt = htype.name
    else
      ""
    end
  end
end
