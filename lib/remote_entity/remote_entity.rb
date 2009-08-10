module RemoteEntity
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
  
    # Returns the domain for the service for this application
    def self.service_domain(service)
      return "#{service}.gnoso.com"
    end
  
    # Returns the service uri for the given service at the given version
    def self.service_uri(service, version)
      return "https://#{self.service_domain(service.to_s)}/api/v#{version.to_s}/"
    end
  end
end