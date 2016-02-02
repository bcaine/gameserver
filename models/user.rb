require 'data_mapper'
require 'json'
require './models/token'

class User
	include DataMapper::Resource
	property :id, Serial
	property :wins, Integer, :default => 0
	property :losses, Integer, :default => 0
	property :total, Integer, :default => 0
	property :created_at, DateTime, :default => Time.now

	def to_json
	    { :id => id,
          :wins => wins,
          :losses => losses,
          :total => total,
          :created_at => created_at
        }.to_json
	end
end
