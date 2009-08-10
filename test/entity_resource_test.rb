require 'test/test_helper'

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
  
end