require 'data_mapper'
require 'json'
require './models/user'

class Token
	include DataMapper::Resource
	property :id, Serial
	property :game_id, Integer
	property :created_at, DateTime, :default => Time.now
	property :expires_at, DateTime

	belongs_to :user, :model => 'User', :child_key => [:user_id]

	def to_json
		{ :id => id, :user_id => user_id, :game_id => game_id, :created_at => created_at, :expires_at => expires_at }.to_json
	end

	def isExpired?
		expires_at > created_at
	end

end
