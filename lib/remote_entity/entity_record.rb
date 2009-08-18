module RemoteEntity
  module EntityRecord
      
    def self.included(base)
      base.class_eval do
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
    
    attr_accessor :remote_entity_id
    def remote_entity_id
      if id
        return "#{RemoteEntity.service}-#{self.class.name.underscore.gsub("/", "_")}-#{id}"
      else
        return nil
      end
    end
  end
end