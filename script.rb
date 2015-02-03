require './auto_follower.rb'

robot = AutoFollower.new
puts "favoriting"
robot.favoriteTime("tennis", 40)
puts "unfavoriting"
robot.unfollowLast(40)
puts "done"