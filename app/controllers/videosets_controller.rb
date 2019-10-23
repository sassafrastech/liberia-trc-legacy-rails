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
      # process filter params
      if params[:clear] == "1"
        session[:filter] = {:region => "any", :month => "any", :linitial => "any", :htype => "any"}
        session[:page] = nil
        redirect_to(@set)
      else
        session[:filter] ||= {:region => "any", :month => "any", :linitial => "any", :htype => "any"}
        session[:page] = params[:page] || session[:page]

        # read new filter criteria from params (if any)
        new_filter = {}
        session[:filter].each_key{|k| new_filter[k] = params[k] || session[:filter][k]}

        # if any changes, do stuff
        if new_filter != session[:filter]
          session[:page] = nil
          session[:filter] = new_filter
        end
      end

      # always set the videoset id
      session[:filter] ||= {}
      session[:filter][:set_id] = @set.id

      # get videos
      filter_clause = Video.filter_clause(session[:filter])
      @videos = Video.paginate_and_filter(session[:page], filter_clause)

      # check if there are filter criteria set
      @can_clear = !session[:filter].reject{|k,v| ![:region, :month, :linitial, :htype].include?(k)}.values.compact.empty?

      # get filter options
      @regions = Region.all_by_country_and_name
      @months = Video.months_with_videos(@set.id)
      @linitials = Video.last_initials_with_videos(@set.id)
      @htypes = HearingType.all_by_name
    else
      @videos = @set.videos.paginate(:page => 1, :order => "recorded_on, title")
    end
  end
end
