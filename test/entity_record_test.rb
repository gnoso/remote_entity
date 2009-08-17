require 'test/test_helper'

class Mouse < ActiveRecord::Base
  include RemoteEntity::EntityRecord
end
RemoteEntity::RemoteEntity.service = "remoteentitytests"

class EntityRecordTest < Test::Unit::TestCase
  
  test "that the remote entity id returns the correct remote entity id" do
    mouse = Mouse.new({ :name => "Harold" })
    mouse.save
    
    assert_equal "remoteentitytests-mouse-#{mouse.id}", mouse.remote_entity_id
  end
end