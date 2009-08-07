class RemoteEntity
  attr_accessor :service
  attr_accessor :resource
  attr_accessor :id
  
  # Constructs a new remote entity object.
  def initialize(remote_entity_id)
     parts = remote_entity_id.split('-', 3)
     if parts.length != 3
       raise "Entity id given is not a proper entity id"
     end
     
     self.service, self.resource, self.id = parts
  end
end