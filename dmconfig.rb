require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/game_server.db")
DataMapper.finalize
DataMapper.auto_upgrade!