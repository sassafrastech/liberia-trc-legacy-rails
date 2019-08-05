class VideosController < ApplicationController
  def index
    redirect_to(:controller => :videosets)
  end
  def show
    @video = Video.find(params[:id])
    @title = @video.title
    set_crumb([["Videos", videosets_path], [@video.videoset.title, videoset_path(@video.videoset)], @video.title])
  end
end
