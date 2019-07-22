namespace :db do
  desc "Populate hearing types."
  task :populate_hearing_types => :environment do

    reset(HearingType)
    HearingType.create(:id => 1, :name => "Confession, Repentance, Forgiveness, and Reconciliation")
    HearingType.create(:id => 2, :name => "Historical Hearings")
    HearingType.create(:id => 3, :name => "Historical Review of Religion and Cultures in Liberia")
    HearingType.create(:id => 4, :name => "Institutional and Thematic")
    HearingType.create(:id => 5, :name => "Institutional and Thematic Hearing on Women")
    HearingType.create(:id => 6, :name => "Institutional and Thematic Hearings on Children")
    HearingType.create(:id => 7, :name => "Institutional and Thematic Hearings on Economic Crimes")
    HearingType.create(:id => 8, :name => "Institutional and Thematic Hearings on Media")
    HearingType.create(:id => 9, :name => "Institutional and Thematic Hearings on Reparation")
    HearingType.create(:id => 10, :name => "Institutional and Thematic Hearings on Women, Monrovia")
    HearingType.create(:id => 11, :name => "Lutheran Massacre")
  end
end

def reset(klass)
  klass.delete_all
  klass.connection.execute("ALTER TABLE #{klass.table_name} AUTO_INCREMENT = 0")
end
