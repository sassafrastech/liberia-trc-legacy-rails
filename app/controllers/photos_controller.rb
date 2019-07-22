class PhotosController < ApplicationController 
  def index
    redirect_to(albums_path)
  end
  def show
    @photo = Photo.find(params[:id])
    set_crumb([["Multimedia", "/multimedia"], ["Photos", albums_path]] )
    a = @photo.album
    loop { @crumb.insert(2, [a.title, album_path(a)]); break if (a = a.parent).nil? }
    @crumb << ["Photo ##{@photo.id}"]
  end
end