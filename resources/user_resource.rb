require 'sinatra'
require './models/user.rb'

class UserResource < Sinatra::Base

	get '/users/' do
		users = User.all :order => :id.asc
		user_array = []
		users.each do |user|
			user_array << user.to_json
		end
		user_array.to_json
	end

	get '/users/:id' do
		user = User.get params[:id]
		if user
			user.to_json
		else
			404
		end
	end

	post '/users/' do
		user = User.new
		if user.save!
			user.id
		else
			500
		end
	end
end