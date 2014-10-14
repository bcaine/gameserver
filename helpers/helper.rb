
# Load all the game types from the game directory.
def get_games
	gameTypes = []
	Dir["./games/*.rb"].each do |game|
		gameTypes << game.split('/')[2].gsub(".rb", "")
	end
	gameTypes
end

# Change our underscores class to CamelCase to use to load classes
# There is a more robust version in Rails, but this should work for
# our purposes.
def camelize(string)
    string.replace(string.split("_").each {|s| s.capitalize! }.join(""))
end

def get_game(game_name)
	game_name = game_name.to_s
	Object.const_get(game_name)
end
