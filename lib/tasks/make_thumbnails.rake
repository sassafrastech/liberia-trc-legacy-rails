# lib/tasks/import_photos.rake
# require "mini_magick"
require "ftools"

namespace :videos do
  desc "Make or remake thumbnails for all existing videos that don't have thumbnails."
  task :make_thumbnails => :environment do

    frame_to_thumbnail = {}
    
    # Scan all files.
    Video.all.each do |vid|
      thumb_path = vid.path('thumbnail', false)
      next if vid.library_dl_url.nil?
      
      orig_path = vid.library_dl_url
      time = frame_to_thumbnail[vid.id] || "00:00:10"
      
      try = 0
      
      while !File.size?(thumb_path) && try < 5
        puts "\n\nThumbnailing #{vid.id} (#{vid.title})"
        pid = Kernel.fork do
          Kernel.exec("ffmpeg -i #{orig_path} -an -ss #{time} -an -s 160x120 -r 1 -vframes 1 -y -f mjpeg #{thumb_path}")
        end
        sleep(5)
        Process.kill(9,pid)
        try += 1
      end
    end
  end
end