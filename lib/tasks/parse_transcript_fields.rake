namespace :db do
  desc "Parse trascript fields."
  task :parse_transcript_fields => :environment do
    Transcript.all.each do |t|
      if t.tmp.match(/\{"id":"3","value":"(\d+)"\}/)
        puts t.region_id = $1
      else
        puts 'no match for region'
      end
      if t.tmp.match(/\{"id":"5","value":"(.+?)"\}/)
        puts t.recorded_on = Time.parse($1)
      else
        puts 'no match for date'
      end
      if t.tmp.match(/\{"id":"4","value":"(.+?)"\}/)
        puts t.municipality = $1
      else
        puts 'no match for municip'
      end
      t.save
    end
  end
end