require 'test/test_helper'

class RemoteEntityTest < Test::Unit::TestCase
  
  test "that incorrect entities raise an exception when being parsed" do
    assert_raise RuntimeError do
      RemoteEntity.new('test-entity')
    end
  end
  
  test "that entities are parsed correctly by RemoteEntity" do
    ent = RemoteEntity.new("test-entity-with-weird-id")
    
    assert_equal 'test', ent.service
    assert_equal 'entity', ent.resource
    assert_equal 'with-weird-id', ent.id
  end
end