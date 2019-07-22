class PressReleasesController < ApplicationController
  # GET /press_releases
  # GET /press_releases.xml
  def index
    set_crumb([["News", "/news"], "Press Releases"])
    @press_releases = PressRelease.paginate(:all, :page => params[:page], :per_page => params[:per_page])

  end

  def show
    @press_release = PressRelease.find(params[:id])
    set_crumb([["News", "/news"], ["Press Releases", press_releases_path], @press_release.title])
    @title = "Press Releases"
  end
end
