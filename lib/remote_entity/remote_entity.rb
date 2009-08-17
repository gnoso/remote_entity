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
      return "#{lookup_service(service)[:uri]}/api/v#{version.to_s}/"
    end
    
    # Registers a service so that we can build urls from it. Holla!
    def self.register_service(service_name, service_uri, service_api_key = "")
      services[service_name.to_sym] = { :uri => service_uri, 
          :api_key => service_api_key }
    end
    
    def self.lookup_service(service)
      result = services[service.to_sym]
      raise "Service `#{service.to_s}` not found" if !result
      
      return result
    end
    
    def self.service=(service)
      @@service = service
    end
    
    def self.service
      @@service ||= nil
    end
    
    private 
    def self.services
      @@services ||= {}
    end
  end
end