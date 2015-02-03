require './auto_follower.rb'

robot = AutoFollower.new

if Time.now.wday%2 == 0 #unfollows every other day
	puts "unfavoriting"
	robot.unfollowLast(100)
end

puts "favoriting"
robot.favoriteTime("tennis", 50)
puts "done"