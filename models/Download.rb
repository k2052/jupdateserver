class Download
  include MongoMapper::EmbeddedDocument

  key :type,   String, :default => 'full'
  key :format, String, :default => 'zip'
  key :url,    String

  ##
  # Associations
  embedded_in :update

  def root_tag
    return :downloads
  end

  def children_tag
    return :downloadurl
  end

  def attributes_as_xml_elements
    return false
  end

  def value
    return self[:url]
  end
end