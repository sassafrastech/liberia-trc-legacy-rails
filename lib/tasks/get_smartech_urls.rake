require 'open-uri'

namespace :db do
  desc "Get SMARTECH URLs."
  task :get_smartech_urls => :environment do
    Video.find(:all, :conditions => "(library_stream_url is null or library_dl_url is null)").each do |vid|
      main_page = ""
      puts "Processing #{vid.title}"
      puts "Opening main page"
      open("http://smartech.gatech.edu/handle/#{vid.library_alt_id}"){|f| main_page = f.readlines.join}
      
      if vid.library_dl_url.nil? 
        if main_page.match(/href="(.+?)".+\n.+\n.+Download Video/)
          puts "Download link found. #{$1}"
          vid.library_dl_url = "http://smartech.gatech.edu#{$1}"
        else
          puts "No download link found."
        end
      end
      
      #if main_page.match(/href="(.+?)".+\n.+\n.+Streaming Video/)
      if vid.library_stream_url.nil?
        if main_page.match(/href="(.+?_streaming.+?)"/)
          puts "Streaming link found. #{$1}"
          puts "Opening streaming page."
        
          stream_page = ""
          open("http://smartech.gatech.edu#{$1}"){|f| stream_page = f.readlines.join}
        
          # get link
          if stream_page.match(/(rtmp:\/\/.+)(&|")/i)
            puts "RTMP link found. #{$1}"
            vid.library_stream_url = $1
          else
            puts "No RTMP link found."
          end
        else
          puts "No streaming link found."
        end
      end
      
      vid.save
      puts ""
    end
  end
end