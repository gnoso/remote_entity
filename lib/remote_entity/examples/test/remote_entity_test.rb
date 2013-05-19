require 'test/test_helper'

class RemoteEntityTest < Test::Unit::TestCase
  
  test "that incorrect entities raise an exception when being parsed" do
    assert_raise RuntimeError do
      RemoteEntity::RemoteEntity.new('test-entity')
    end
  end
  
  test "that entities are parsed correctly by RemoteEntity" do
    ent = RemoteEntity::RemoteEntity.new("test-entity-with-weird-id")
    
    assert_equal 'test', ent.service
    assert_equal 'entity', ent.resource
    assert_equal 'with-weird-id', ent.id
  end
  
  test "that the correct resource uri is returned for a RemoteEntity" do
    RemoteEntity::RemoteEntity.register_service(:cart, "https://cart.gnoso.com",
        'test')
    assert_equal 'https://cart.gnoso.com/api/v3/', 
        RemoteEntity::RemoteEntity.service_uri(:cart, 3)
  end
  
  test "that defining the name of the current service works" do
    RemoteEntity::RemoteEntity.service = "aservice"
    
    assert_equal "aservice", RemoteEntity::RemoteEntity.service
  end
end