require File.dirname(__FILE__) + "/../../../lib/remote_entity/remote_entity"
require File.dirname(__FILE__) + "/../../../lib/remote_entity/entity_resource"

RemoteEntity::RemoteEntity.register_service(:testapp, 'http://0.0.0.0:3000')