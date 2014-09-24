namespace :facebook do
  desc "Retrieve albums"
  task :retrieve_albums => :environment do | t, args| 
    
    #puts ENV["FACEBOOK_APP_TOKEN"].
    #return if ENV["FACEBOOK_APP_TOKEN"].blank? 

    @graph = Koala::Facebook::API.new("774534099241810|4BaudRvKaQcKe-qRLZYdnZLaWIw")    
    @albums = @graph.api("193875377299310/albums?limit=10")["data"]

    @albums.each do |album|
      puts album.inspect
      #puts "#{album["id"]} - #{album["name"]}"
    end

  end

end
