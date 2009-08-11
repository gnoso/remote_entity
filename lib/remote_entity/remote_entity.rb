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
  
    # Returns the service uri for the given service at the given version
    def self.service_uri(service, version)
      return "#{@@services[service][service_uri]}/api/v#{version.to_s}/"
    end
    
    # Registers a service so that we can build urls from it. Holla!
    def self.register_service(service_name, service_uri, service_api_key)
      @@services ||= {}
      @@[service_name] = { :uri => service_uri, :api_key => service_api_key }
    end
  end
end