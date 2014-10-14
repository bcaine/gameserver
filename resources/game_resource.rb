require 'sinatra'
require './models/user'
require './models/game'
require './helpers/helper'

# Require every game in our games directory.
Dir["./games/*.rb"].each {|file| require file }

class GameResource < Sinatra::Base
	# Time until token expiration. This should probably be configurable in the future. 
	# 3600 seconds * 1 hour = 1 hour.
	token_expiration = 3600 * 1

	# Get a list of games
	game_types = get_games

	# curl localhost:4567/games/
	get '/games/' do
		game_types.to_json
	end

	# curl -X PUT -H "Content-Type: application/json" -d '{"guess": "5"}' localhost:4567/games/1/
	put '/games/:token/' do
		# Get the JSON that is passed in on the request
		request_json = JSON.parse(request.body.read)

		return "Please provide a json blob with your turn".to_json if request_json.empty?

		token = Token.get params[:token]

		if token
			unless token.is_expired?
				game = get_game(token.game_type).get token.game_id
				user = User.get token.user_id
				response = game.play(request_json)

				# If either update fails (tries to save and can't), return a server error (500)
				return 500.to_json unless update_user_record(user, response)
				return 500.to_json unless game.save
			else
				response = "Your token has expired!"
			end
		else
			return 404.to_json
		end

		response.to_json
	end

	# curl -X POST -d '' localhost:4567/games/guess_number/user/1/
	post '/games/:game_type/user/:user_id/' do

		user = User.get params[:user_id]

		return 400.to_json unless game_types.include? params[:game_types]

		game = get_game(camelize(params[:game_type])).new

		if game.save && user.save
			# We don't care if there was a previous token, we are overwriting it
			token = Token.new
			token.user_id = user.id
			token.game_id = game.id
			token.game_type = game.type
			token.expires_at = Time.now + token_expiration
		else
			return 500.to_json
		end

		if token.save
			{ :game_token => token.id }.to_json
		else
			500.to_json
		end
	end
end