class StaticController < ApplicationController 
  
  def index
    @title = "TRC Final Report Released"
  end
  
  def show
    params[:section] ||= ""
    params[:subsection] ||= ""
    render :template => File.join("static", params[:section], params[:subsection], params[:page])
  end

end