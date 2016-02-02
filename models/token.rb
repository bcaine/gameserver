require 'data_mapper'
require 'json'
require './models/user'

class Token
	include DataMapper::Resource
	property :id, Serial
	property :game_id, Integer
	property :game_type, String
	property :created_at, DateTime, :default => Time.now
	property :expires_at, DateTime

	belongs_to :user, :model => 'User', :child_key => [:user_id]

	def to_json
	    { :id => id,
          :user_id => user_id,
          :game_id => game_id,
          :game_type => game_type,
          :created_at => created_at,
          :expires_at => expires_at
        }.to_json
	end

	def is_expired?
		Time.now > Time.parse(expires_at.to_s)
	end
end
