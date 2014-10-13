require 'data_mapper'

# This file is used to configure our SQLite instance and our DataMapper
# We include this in our main application and it should handle setting up the
# database and our model's relationships for us.
DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/game_server.db")
DataMapper.finalize
DataMapper.auto_upgrade!