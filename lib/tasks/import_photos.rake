# lib/tasks/import_photos.rake
# require "mini_magick"
require "ftools"

namespace :db do
  desc "Import photos."
  task :import_photos => :environment do

    reset(Album)
    reset(Photo)
    %w(originals normals thumbnails).each{|d| `rm public/images/gallery/#{d}/*.jpg`}
    import_dir("public/images/gallery/originals")
    

  end
end

def reset(klass)
  klass.delete_all
  klass.connection.execute("ALTER TABLE #{klass.table_name} AUTO_INCREMENT = 0")
end


def import_dir(root, sub = nil, parent = nil)

  # Create album (unless sub is nil).
  unless sub.nil?
    base = File.basename(sub)
    title = base.gsub(/_\d{1,2}$/, "").gsub(/_/, " ").strip.split(" ").collect{|w| %w(the a and for it from in to).include?(w) ? w : w.capitalize}.join(" ")
    album = Album.create(:title => title, :parent_id => parent ? parent.id : nil)
  end

  sub ||= root

  # Scan all files.
  Dir.new(sub).each do |f|
    next if f.match(/^\./)
    path = File.join(sub, f)
    
    # If folder, go down.
    if File.directory?(path)
      import_dir(root, path, album)
    else
    # Else, create file in root and photo.
      photo = Photo.create(:album_id => album.id)
      File.copy(path, File.join(root, "#{photo.id}.jpg"))
      image = MiniMagick::Image.from_file(path)
      image.resize("133x99")
      image.write(File.join(root, "..", "thumbnails", "#{photo.id}.jpg"))
      image = MiniMagick::Image.from_file(path)
      if image[:width].to_i > 720
        puts "Creating normal"
        image.resize("745x540")
        image.write(File.join(root, "..", "normals", "#{photo.id}.jpg"))
      else
        puts "Skipping normal (#{image[:width]})"
      end
    end
  end
  
end