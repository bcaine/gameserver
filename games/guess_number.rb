require './models/game'

class GuessNumber
	include Game
	property :id, Serial
	property :chances, Integer, :default => 10
	property :tries, Integer, :default => 0
	property :number, Integer, :default => rand(100)

	# Take a turn at the game
	def play(json_data)
		# If they already won, return
		if self.done
			return { :won => self.won, :response => "You already won!", :tries => self.tries, :chances => self.chances }
		end

		if json_data["guess"].nil?
			# We have mercy and don't count this as an attempt (try).
			return { :response => "Provide a guess like: '{\"guess\": \"5\"}'", :tries => self.tries, :chances => self.chances }
		end

		guess = json_data["guess"].to_i
		response = {}

		if self.tries >= self.chances
			won = false
			done = true
			response = { :won => self.won, :response => "Out of tries!", :tries => self.tries, :chances => self.chances }
		end

		# Increment our try count
		self.tries += 1

		if self.number == guess
			self.won = true
			self.done = true
			response = { :won => self.won, :done => self.done, :response => "Congrats, You won!", :tries => self.tries, :chances => self.chances }
		elsif self.number > guess
			response = { :response => "Guess a higher number.", :tries => self.tries, :chances => self.chances }
		else
			response = { :response => "Guess a lower number.", :tries => self.tries, :chances => self.chances }
		end

		response
	end
end