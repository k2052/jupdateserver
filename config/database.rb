MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'jupdateserver_development'
  when :production  then MongoMapper.database = 'jupdateserver_production'
  when :test        then MongoMapper.database = 'jupdateserver_test'
end