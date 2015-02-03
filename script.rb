require './auto_follower.rb'

robot = AutoFollower.new
puts "favoriting"
robot.favoriteTime("tennis", 40)
if Time.now.wday%2 == 0 #unfollows every other day
	puts "unfavoriting"
	robot.unfollowLast(80)
end
puts "done"