require 'sinatra'
require './resources/user_resource'
require './resources/game_resource'
require './dmconfig'

# This is our main server we run. 
# The majority of the resources are in UserResource and GameResource

class GameServer < Sinatra::Base
    use UserResource
    use GameResource

    get '/' do
        "Welcome to Ben's Game Server!\n"
    end
end

GameServer.run!
