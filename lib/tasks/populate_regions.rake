namespace :db do
  desc "Populate regions."
  task :populate_regions => :environment do

    reset(Region)
    Region.create(:name => "Bomi", :capital => "Tubmanburg", :country => "Liberia")
    Region.create(:name => "Bong", :capital => "Gbarnga", :country => "Liberia")
    Region.create(:name => "Gbarpolu", :capital => "Bopulu", :country => "Liberia")
    Region.create(:name => "Grand Bassa", :capital => "Buchanan", :country => "Liberia")
    Region.create(:name => "Grand Cape Mount", :capital => "Robertsport", :country => "Liberia")
    Region.create(:name => "Grand Gedeh", :capital => "Zwedru", :country => "Liberia")
    Region.create(:name => "Grand Kru", :capital => "Barclayville", :country => "Liberia")
    Region.create(:name => "Lofa", :capital => "Voinjama", :country => "Liberia")
    Region.create(:name => "Margibi", :capital => "Kakata", :country => "Liberia")
    Region.create(:name => "Maryland", :capital => "Harper", :country => "Liberia")
    Region.create(:name => "Montserrado", :capital => "Bensonville", :country => "Liberia")
    Region.create(:name => "Nimba", :capital => "Sanniquellie", :country => "Liberia")
    Region.create(:name => "River Cess", :capital => "River Cess", :country => "Liberia")
    Region.create(:name => "River Gee", :capital => "Fish Town", :country => "Liberia")
    Region.create(:name => "Sinoe", :capital => "Greenville", :country => "Liberia")
    Region.create(:name => "Minnesota", :capital => "St. Paul", :country => "USA")

  end
end

def reset(klass)
  klass.delete_all
  klass.connection.execute("ALTER TABLE #{klass.table_name} AUTO_INCREMENT = 0")
end
