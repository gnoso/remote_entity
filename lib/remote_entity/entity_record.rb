require 'active_record'

module RemoteEntity
  module EntityRecord
    module ClassMethods
   
      def belongs_to_remote_entity(association_id, options = {})
        define_accessible(association_id, options)
        define_constructors(association_id, options)
      end
    
      private
      def define_accessible(association_id, options)
        association_class = 
            Object.const_get(association_id.to_s.camelize.to_sym)
            
        if !private_method_defined?("remote_entity_cache")
          define_method("remote_entity_cache") do
            @remote_entity_cache ||= {}
          end
        end
        if !private_method_defined?("remote_entity_dirty_vals")
          define_method("remote_entity_dirty_vals") do
            @remote_entity_dirty_vals ||= {}
          end
        end
        
        define_method("#{association_id.to_s}_remote_entity_object") do
          service = association_class.service
          resource = association_class.name.underscore
          
          RemoteEntity.new(
              self.send("#{association_id.to_s}_id").to_s)
        end
        
        define_method("#{association_id.to_s}".to_sym) do
          if remote_entity_dirty_vals.has_key?(association_id)
            remote_entity_dirty_vals[association_id]
          else
            id = self.send("#{association_id.to_s}_remote_entity_object").id
            remote_entity_cache[association_id] ||= association_class.find(id)
          end
        end
      
        define_method("#{association_id.to_s}=".to_sym) do |value|
          remote_entity_cache[association_id] = nil
          
          self.send("#{association_id.to_s}_id=", value.remote_entity_id)
          remote_entity_dirty_vals[association_id] = value
        end
      end
    
      def define_constructors(association_id, options)
        define_method("build_#{association_id}") do |*params|
          attributes = params.first
        end
      
        define_method("create_#{association_id}") do |*params|
          attributes = params.first
        end
      end
    end
  end
end

ActiveRecord::Base.extend RemoteEntity::EntityRecord::ClassMethods