module RemoteEntity
  module EntityRecord
      
    attr_accessor :remote_entity_id
    def remote_entity_id
      if id
        return "-monkey-#{id}"
      else
        return nil
      end
    end

    alias_method :old_to_xml, :to_xml
    def to_xml(options = {})
      if !options[:methods]
        options[:methods] = [ :remote_entity_id ]
      else
        options[:methods] << :remote_entity_id
      end

      old_to_xml(options)
    end
  end
end