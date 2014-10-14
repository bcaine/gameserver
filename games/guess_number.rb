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
		return generate_response "You already won!" if self.done

		# If they don't provide a guess we let them know, have mercy, and don't count this as an attempt (try).
		return generate_response "Provide a guess like: '{\"guess\": \"5\"}'" if json_data["guess"].nil?

		guess = json_data["guess"].to_i

		if self.tries >= self.chances
			won = false
			done = true
			return generate_response "Out of tries!"
		end

		# Increment our try count
		self.tries += 1

		if self.number == guess
			self.won = true
			self.done = true
			generate_response "Congrats, You won!"
		elsif self.number > guess
			generate_response "Guess a higher number."
		else
			generate_response "Guess a lower number."
		end
	end

	def generate_response(response)
		{
			:response => response,
			:tries => self.tries,
			:chances => self.chances,
			:won => self.won,
			:done => self.done
		}
	end
end