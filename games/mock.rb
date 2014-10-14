require './models/game'

class Mock
	include Game

	property :id, Serial

	def play(json_data)
		{}
	end
end