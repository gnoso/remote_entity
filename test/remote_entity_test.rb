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
  
  test "that the correct domain is returned for a RemoteEntity" do
    assert_equal 'cart.gnoso.com', RemoteEntity.service_domain('cart')
  end
  
  test "that the correct resource uri is returned for a RemoteEntity" do
    assert_equal 'https://cart.gnoso.com/api/v3/', 
        RemoteEntity.service_uri('cart', 3)
  end
end