module SerializeHashToXMLAttributes
  # This is greatly simplified and will probably fail in a lot of use cases
  def to_xml(options = {}, &block)
    options[:indent] ||= 2
    builder = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])

    unless options[:skip_instruct]
      builder.instruct!
      options[:skip_instruct] = true
    end

    options[:only]   = Array.wrap(options[:only]).map { |k| k.to_s }
    options[:except] = Array.wrap(options[:except]).map { |k| k.to_s }

    attribute_names = serializable_attributes

    if options[:only].any?
      attribute_names &= options[:only]
    elsif options[:except].any?
      attribute_names -= options[:except]
    end

    attribute_names += Array.wrap(options[:methods]).map { |m| m.to_s }.select do |method|
      respond_to?(method)
    end

    options[:root] ||= self.class.to_s.downcase

    builder.tag! options[:root] do |root|
      attribute_names.each do |attribute|
        value        = self.send(attribute.to_sym)
        root_tag     = value.respond_to?(:root_tag) ? value.root_tag : attribute

        if value.respond_to?(:serializable_hash)
          builder.tag!(root_tag, value.serializable_hash, value.respond_to?(:serializable_hash) ? value.value : '')
        elsif value.is_a?(Array)
          tag_content = ''
          builder.tag! root_tag do |root|
            value.each do |v|
              children_tag = v.respond_to?(:children_tag) ? v.children_tag : attribute
              attributes_as_xml_elements = v.respond_to?(:attributes_as_xml_elements) ? v.attributes_as_xml_elements : false
              if attributes_as_xml_elements
                root << Builder::XmlMarkup.new(:indent => options[:indent]).tag!(children_tag, 
                      v.respond_to?(:serializable_hash) ? v.serializable_hash : v, v.respond_to?(:serializable_hash) ? v.value : '')
              else
                root << v.to_xml(:skip_instruct => true)
              end
            end
          end
        else
          builder.tag!(root_tag, value)
        end
      end
    end

    yield builder if block_given?
    return builder.to_s
  end
end