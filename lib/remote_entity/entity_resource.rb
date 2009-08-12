require 'active_resource'

module RemoteEntity
  class EntityResource < ActiveResource::Base
    
    def initialize(attrs = {})      
      @@schema ||= []
      
      attrs = HashWithIndifferentAccess.new(attrs)
      @@schema.each do |attribute|
        if !attrs.has_key?(attribute)
          attrs[attribute] = nil
        end
      end
      if !attrs.has_key?(:remote_entity_id)
        attrs[:remote_entity_id] = nil
      end
      
      super(attrs)
    end
    
    # Defines methods for the following properties on every instance of this
    # type that is created
    def self.schema(*args)
      @@schema = args
    end
    
    # Helps us set the site automatically.
    def self.version=(version)
      @@api_version = version
      self.update_site
    end
    
    def self.version
      return defined?(@@api_version) ? @@api_version : nil
    end
    
    # Helps us set the site automatically
    def self.service=(service)
      @@service = service
      self.update_site
    end
    
    def self.service
      return defined?(@@service) ? @@service : nil
    end
    
    private
    def self.update_site
      self.site = RemoteEntity.service_uri(self.service,
          self.version)
    end
  end
end