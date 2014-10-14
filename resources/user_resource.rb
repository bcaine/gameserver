require 'sinatra'
require './models/user.rb'

class UserResource < Sinatra::Base

	# curl localhost:4567/users/
	get '/users/' do
		users = User.all :order => :id.asc
		users.collect{ |user| user.to_json }.to_json
	end

	# curl localhost:4567/users/1
	get '/users/:id/' do
		user = User.get params[:id]
		user.nil? ? 404.to_json : user.to_json
	end

	# curl -X POST -d '' localhost:4567/users/
	post '/users/' do
		user = User.new
		user.save! ? { :user_id => user.id }.to_json : 500.to_json
	end
end