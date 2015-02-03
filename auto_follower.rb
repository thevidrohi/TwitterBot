require './micro_blogger'
#https://dev.twitter.com/rest/public/search

class AutoFollower < MicroBlogger
	def favoriteTime(query, maxDaily)
		query = url_encode(query)
		searchResults = @client.search(query, result_type: "mixed", count: 40) 
		searchResults.take(maxDaily).each do |tweet|
			@client.favorite(tweet)
		end
	end

	def unfollowLast(amount)
		favorites = @client.favorites(count: amount) #max of 100
		favorites.each do |tweet|
			@client.unfavorite(tweet)
		end
	end

	def url_encode(query)
		#eventually I can include this encoding--as per the above--for more complex searches
		query
	end
end

#robot.followTime(40)
#catch(:stopService) do |variable|
#	robot = AutoFollower.new
#	robot.followTime(50)
#end