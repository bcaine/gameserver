require 'sinatra'
require './models/user.rb'

class UserResource < Sinatra::Base

	# curl localhost:4567/users/
	get '/users/' do
		users = User.all :order => :id.asc
		user_array = []
		users.each do |user|
			user_array << user.to_json
		end
		user_array.to_json
	end

	# curl localhost:4567/users/1
	get '/users/:id/' do
		user = User.get params[:id]
		if user
			user.to_json
		else
			404.to_json
		end
	end

	# curl -X POST -d '' localhost:4567/users/
	post '/users/' do
		user = User.new
		if user.save!
			{ :user_id => user.id }.to_json
		else
			500.to_json
		end
	end
end