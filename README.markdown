Remote Entity
=============

Remote Entity defines a pattern for working with REST services. It defines a versioning scheme, a remote entity identifier scheme, and adds some useful features to ActiveRecord and ActiveResource for working with those schemes.

Installing Remote Entity
------------------------
The best way to install Remote Entity is with RubyGems.

    sudo gem install gnoso-remote_entity
    
Understanding Remote Entity IDs
-------------------------------
Remote Entity makes a lot of assumptions about how you create and consume services, and those constraints help make services simpler to write and work with (at least in theory).

Entity IDs are made up of 3 components - service, resource, and id. Entity IDs are represented as a string made up of these three components, separated by dashes.

    service-resource-entity_id

The service name should be universally unique (although there is at present no way to guarantee that the service name is universally unique). The name should also be made up of only lowercase letters, numbers, and the underscore character.

The resource maps roughly to the name of the object that is being worked with. Resources should only be made up of lowercase letters, numbers, and the underscore character.

The ID is the actual unique id for the resource within the service. It can be made up of any lowercase or uppercase letter (a-zA-Z), any digit (0-9), or the special characters '-', '_', '$', '@', '+', '"', ''', '*', '!', or '|'.

There is an additional limitation on remote entity IDs that the length be less than 255 characters. This allows them to be easily stored in a typical SQL varchar field.

Because Remote Entity uses a standard URL format, the URL for a Remote Entity can be easily determined. The format for an entity is as follows:

{service}/api/v{version}/{resource}/{id}

The service location and version should be specified at runtime.

Providing Remote Entity Services
--------------------------------
At present, Remote Entity doesn't help out with routing and controllers for services. At Gnoso, we map routes with a namespace:

    map.namespace(:api) do |api|
      api.namespace(:v1) do |v1|
        v1.resources :whatever
      end
    end

Routing like that expects a controller named Api::V1::Whatever. As we increment versions, we copy our controllers and improve them as needed. Testing also ends up working out well in this way, because we end up with tests arranged into modules based on the version.

Remote Entity adheres to the conventions that ActiveResource provides for services, so Remote Entity resources should be offered in both XML and JSON formats. Additionally, Remote Entity expects that an attribute called remote_entity_id be in each instance of a resource. The RemoteEntity::EntityRecord module provides a basic instance of this attribute, based on the ActiveRecord model name and id. To use this, you will need to register the current service name with the following code (probably in an initializer):

    RemoteEntity::RemoteEntity.service = :my_service_name

You can override the remote_entity_id method in your model to customize it, but the remote_entity_id should adhere to the Remote Entity ID rules defined above.

Consuming Remote Entity Services
--------------------------------
Remote Entity provides a module named RemoteEntity::EntityResource that can be included in an ActiveResource object to make it easier to work with RemoteEntity resources. To use the class simply register the service that you're working with:

    RemoteEntity::RemoteEntity.register_service(:my_service,
        "https://my.service.com", "some_cool_api_key")
        
Then, include the module in your resource and configure it:

    class Monkey < ActiveResource::Base
      include RemoteEntity::EntityResource
      
      self.service = :my_service
      self.version = 1                # the api version
    end
    
You can work with your object just as you would any ActiveResource object.

Remote Entity also provides a nice way to build relationships with ActiveRecord models using the RemoteEntity::EntityRecord::Associations module.

    class Jungle < ActiveRecord::Base
      belongs_to_remote_entity :monkey
    end

This will add the methods monkey=, monkey, build_monkey and create_monkey to the model. The column for the belongs_to relationship in this example should be called monkey_id, and should be a varchar with a length of 255, since it will contain the monkey's Remote Entity ID.

License
-------
Copyright (c) 2008-2009 Gnoso, Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.