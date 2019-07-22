class TranscriptsController < ApplicationController 
  
  def index
    @title = "TRC Transcripts"
    set_crumb([["Hearings", "/hearings"], "Transcripts"])
    @transcripts = Transcript.all_by_date
  end
    
  def show
    @transcript = Transcript.find(params[:id])
    set_crumb([["Hearings", "/hearings"], ["Transcripts", transcripts_path], @transcript.title])
    @title = @transcript.title
  end
end