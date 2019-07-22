class AlbumsController < ApplicationController 
  
  def index
    set_crumb([["Multimedia", "/multimedia"], ["Photos", albums_path]])
    @children = Album.top
    render(:action => :show)
  end
  
  def show
    @album = Album.find(params[:id])
    set_crumb([["Multimedia", "/multimedia"], ["Photos", albums_path]])
    a = @album; loop { @crumb.insert(2, [a.title, album_path(a)]); break if (a = a.parent).nil? }
    @children = @album.children
    @photos = @album.photos
  end
end