require 'data_mapper'
require 'json'
require './models/token'

# DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/game_server.db")

class User
	include DataMapper::Resource
	property :id, Serial
	property :wins, Integer, :default => 0
	property :losses, Integer, :default => 0
	property :total, Integer, :default => 0
	property :created_at, DateTime, :default => Time.now

	has 1, :token, :model => 'Token', :child_key => [:id], :parent_key => [:user_id]

	def to_json
		{ :id => id, :wins => wins, :losses => losses, :total => total, :created_at => created_at }.to_json
	end
end

# DataMapper.finalize.auto_upgrade!
