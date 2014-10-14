require './models/game'
require 'pry'

class GuessNumber
	include Game
	property :id, Serial
	property :chances, Integer, :default => 10
	property :tries, Integer, :default => 0
	property :number, Integer, :default => rand(100)

	# Take a turn at the game
	def play(json_data)
		# If they already won, return
		if self.won
			return { :won => self.won, :response => "You already won!", :tries => self.tries, :chances => self.chances }
		end

		guess = json_data["guess"].to_i
		response = {}

		if self.tries >= self.chances
			won = false
			response = { :won => self.won, :response => "Out of tries!", :tries => self.tries, :chances => self.chances }
		end

		# Increment our try count
		self.tries += 1

		if self.number == guess
			won = true
			response = { :won => self.won, :response => "Congrats, You won!", :tries => self.tries, :chances => self.chances }
		elsif self.number > guess
			response = { :response => "Guess a higher number.", :tries => self.tries, :chances => self.chances }
		else
			response = { :response => "Guess a lower number.", :tries => self.tries, :chances => self.chances }
		end

		response
	end

	def help
		"Provide a guess as a json blob. { \"guess\": \"5\" }".turn_json
	end

end