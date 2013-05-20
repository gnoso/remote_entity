require 'test/test_helper'

class Mouse < ActiveRecord::Base
  include RemoteEntity::EntityRecord
end

module Cat
  class Tabby < ActiveRecord::Base
    include RemoteEntity::EntityRecord
  end
end

RemoteEntity::RemoteEntity.service = "remoteentitytests"

class EntityRecordTest < Test::Unit::TestCase
  
  test "that the remote entity id returns the correct remote entity id" do
    mouse = Mouse.create({ :name => "Harold" })
    mouse.save
    
    assert_equal "remoteentitytests-mouse-#{mouse.id}", mouse.remote_entity_id
  end
  
  test "that correct remote entity id gets returned when a class is in a module" do
    tabby = Cat::Tabby.create({ :name => "Tom" })
    
    assert_equal "remoteentitytests-cat_tabby-#{tabby.id}",
        tabby.remote_entity_id
  end
end