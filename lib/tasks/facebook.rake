namespace :facebook do
  desc "Retrieve albums"
  task :retrieve_albums => :environment do | t, args| 
    
    #puts ENV["FACEBOOK_APP_TOKEN"].
    #return if ENV["FACEBOOK_APP_TOKEN"].blank? 

    @albums.each do |album|
      puts album.inspect
      #puts "#{album["id"]} - #{album["name"]}"
    end

  end

end
