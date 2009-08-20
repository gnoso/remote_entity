module RemoteEntity
  module EntityRecord
    
    def remote_entity_id
      if id
        return "#{RemoteEntity.service}-#{self.class.name.underscore.gsub("/", "_")}-#{id}"
      else
        return nil
      end
    end
  end
end