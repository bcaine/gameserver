require 'data_mapper'
require 'json'
require './models/token'

module Game
	def self.included base
		base.class_eval do
			include DataMapper::Resource
			property :user_id, base::Integer
			property :won, base::Boolean, :default => false
			property :done, base::Boolean, :default => false
			property :created_at, DateTime, :default => Time.now
			property :type, base::Discriminator

			def to_json
				{ :id => id, :gametype => type, :state => state, :created_at => created_at }.to_json
			end

			def play(json_data)
				"Playing has not been implemented for this game!"
			end
		end
	end
end
