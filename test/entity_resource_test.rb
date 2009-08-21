require 'test/test_helper'

RemoteEntity::RemoteEntity.register_service(:cart, "http://cart.local",
    'some_dumb_api_key')
    
class SchemaResource < RemoteEntity::EntityResource
  self.service = :cart
  self.version = 1
  
  schema :name, :age, :gender
end

class EntityResourceTest < Test::Unit::TestCase
  
  test "that the schema method creates methods to read the schema properties" do
    sr = SchemaResource.new

    assert_nothing_raised do 
      sr.name
      sr.age
      sr.gender
    end
  end
  
  test "that the api key gets set correctly" do
    assert_equal "some_dumb_api_key", SchemaResource.user
    assert_equal "", SchemaResource.password
  end
end