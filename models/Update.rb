class Update
  include MongoMapper::Document
  include MongoMapperExt::Tags
  include SerializeHashToXMLAttributes

  key :name,           String
  key :description,    String
  key :element,        String
  key :type,           String
  key :version,        String
  key :infourl,        Hash, :default => {:title => '', :value => ''}
  key :maintainer,     String
  key :maintainerurl,  String
  key :section,        String
  key :targetplatform, Hash, :default => {:name => 'joomla', :version => '2.5'}
  key :client_id,      Integer, :default => 1
  key :folder,         String

  ## 
  # Associations
  #
  many :downloads

  timestamps!
end