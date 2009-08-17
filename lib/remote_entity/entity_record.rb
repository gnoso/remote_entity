module RemoteEntity
  module EntityRecord
      
    attr_accessor :remote_entity_id
    def remote_entity_id
      if id
        return "--#{id}"
      else
        return nil
      end
    end
  end
end