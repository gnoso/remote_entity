module RemoteEntity
  module EntityRecord
    module Assocations
    
      def self.included(base)
        base.extend ClassMethods
      end
    
      module ClassMethods
        def belongs_to_remote(association_id, options = {})
          if options[:class_name].nil?
            options[:class_name] = association_id.to_s.camelize.to_sym 
          end
          
          association_class = 
              Object.const_get(options[:class_name].to_sym)
            
          define_accessible(association_id, options, association_class)
          define_constructors(association_id, options, association_class)
          
          if options[:dependent] == :destroy
            define_destroy(association_id, options, association_class)
            after_destroy "destroy_#{association_id}".to_sym
          end
        end
    
        private
        def define_accessible(association_id, options, association_class)

            
          if !method_defined?("remote_entity_cache")
            define_method("remote_entity_cache") do
              @remote_entity_cache ||= {}
            end
          end
          if !method_defined?("remote_entity_dirty_vals")
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
            elsif !self.send("#{association_id.to_s}_id").nil?
              id = self.send("#{association_id.to_s}_remote_entity_object").id
              remote_entity_cache[association_id] ||= association_class.find(id)
            else
              nil
            end
          end
      
          define_method("#{association_id.to_s}=".to_sym) do |value|
            remote_entity_cache[association_id] = nil
          
            self.send("#{association_id.to_s}_id=", value.remote_entity_id)
            remote_entity_dirty_vals[association_id] = value
          end
        end
    
        def define_constructors(association_id, options, association_class)
          define_method("build_#{association_id}") do |*params|
            attributes = params.first
          
            object = association_class.new(attributes)
          
            self.send("#{association_id.to_s}=", object)
          end
      
          define_method("create_#{association_id}") do |*params|
            attributes = params.first
          
            object = association_class.new(attributes)
            object.save

            self.send("#{association_id}=", object)
          end
        end
        
        def define_destroy(association_id, options, association_class)
          define_method("destroy_#{association_id}") do
            object = self.send("#{association_id}")
            object.destroy
          end
        end
      end
    end
  end
end