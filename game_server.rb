require 'sinatra'
require './resources/user_resource'
require './resources/game_resource'
require './dmconfig'

class GameServer < Sinatra::Base
	use UserResource
	use GameResource

	get '/' do
		# TODO: We want to use this as a directory to guide them through the API
		"Welcome to Ben's Game Server!\n"
	end
end

GameServer.run!