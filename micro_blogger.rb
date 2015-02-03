#require 'jumpstart_auth'
require 'bitly'
require 'twitter'

class MicroBlogger
	attr_reader :client

	def initialize
		#puts "Initializing MicroBlogger"
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key = "0BVjQKytods3GSBbQ3t6x9nOW"
		  config.consumer_secret = "EYhr7sTxO084l9OA7vksBFdetDYWBZrK2s90dbDZU4WrNdtUN2"
		  config.access_token = "3004161963-45opC317UdSjPG76A9yQDONy7nGkf42IlguAMbw"
		  config.access_token_secret = "lHCaJPtFHRnxn5yx6M1OMJLE9y0LgOr4onSmw1GTisVTt"
		end
		Bitly.use_api_version_3
		@bitly = Bitly.new('hungryacademy','R_430e9f62250186d2612cca76eee2dbc6')
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else 
			puts "Sorry, your message was longer than 140 characters. Try again."
		end
	end

	def dm(target, message)
		usernames = followers_list
		unless !usernames.include?(target)
			if message.length <= 140
				@client.d(target, message)
			else 
				puts "Sorry, your message was longer than 140 characters. Try again."
			end
		else
			puts "Sorry, #{target} has to be following you before you can DM."
		end
	end

	def run
		puts "Welcome to the RTech Twitter Client."
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when "q"
					puts "Goodbye."	
				when "t"
					self.tweet(parts[1..-1].join(" "))
				when "dm"
					self.dm(parts[1], parts[2..-1].join(" "))
				when "spam"
					self.spam_my_followers(parts[1..-1].join(" "))
				when "elt"
					self.everyones_last_tweet
				when "s"
					self.shorten(parts[1])
				when "turl"
					self.tweet(parts[1..-2].join(" ")+" "+self.shorten(parts[-1]))
				else
					puts "Command #{t} does not compute."
			end
		end
	end

	def followers_list
		usernames = @client.followers.collect do |follower|
			@client.user(follower).screen_name
		end
		usernames
	end

	def spam_my_followers(message)
		followers_list.each do |follower|
			self.dm(follower, message)
		end
	end

	def everyones_last_tweet
		#friends returns a Cursor object, not an array of Friends objects
		followees = @client.friends
		followees.each do |followee|
			sn = @client.user(followee).screen_name
			puts "@#{sn}"
			puts "#{@client.user(followee).status.text}"
			puts ""
		end
	end

	def shorten(originalURL)
		puts "Shortening this URL: #{originalURL}"
		shortURL = @bitly.shorten(originalURL).short_url
	end
end

#blogger = MicroBlogger.new
#blogger.run
#blogger.tweet("MicroBlogger Initialized!")
#blogger.tweet("".ljust(150, "abcd"))