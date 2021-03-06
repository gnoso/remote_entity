require 'test/test_helper'

RemoteEntity::RemoteEntity.register_service(:testapp, "http://0.0.0.0:3001")
class Monkey < RemoteEntity::EntityResource
  self.service = :testapp
  self.version = 1
  
  schema :name, :age, :gender
end

class Person < ActiveRecord::Base
  include RemoteEntity::EntityRecord::Assocations
  
  belongs_to_remote :monkey
  belongs_to_remote :big_monkey, :class_name => "Monkey", 
      :dependent => :destroy
end

class EntityRecordAssocationsTest < Test::Unit::TestCase
  def setup
    Person.delete_all
  end
  
  test "that defining a belongs_to_remote_entity defines the correct methods on an instance of a class" do
    
    person = Person.new
    assert person.respond_to?(:monkey)
    assert person.respond_to?(:monkey=)
    assert person.respond_to?(:build_monkey)
    assert person.respond_to?(:create_monkey)
  end
  
  test "that a remote entity object can be gotten from the remote entity accessor" do
  
    person = Person.new({ :monkey_id => 'testapp-monkey-1' })
    
    assert_equal "testapp", person.monkey_remote_entity_object.service
    assert_equal "monkey", person.monkey_remote_entity_object.resource
    assert_equal "1", person.monkey_remote_entity_object.id
  end
  
  test "that loading a remote entity when it's nil works" do
    person = Person.new
    
    assert_nil person.monkey
  end
  
  test "that loading a remote entity via association works" do
    Fafactory.purge('testapp')
    id = Fafactory.create('testapp', :monkey)["id"]
    
    person = Person.new({ :monkey_id => "testapp-monkey-#{id}" })
    
    assert_equal "Mongo", person.monkey.name
  end
  
  test "that setting a remote entity as an object works when the remote item doesn't have an id" do
    
    person = Person.new
    monkey = Monkey.new({:name => "Mongo"})
    assert_equal "Mongo", monkey.name
    
    person.monkey = monkey
    assert_equal "Mongo", person.monkey.name
    assert_nil person.monkey_id
  end
  
  test "that settingn a remote entity as an object works when the remote item has an id" do
    person = Person.new
    monkey = Monkey.new({ :name => "Mongo", 
        :remote_entity_id => "testapp-monkey-1" })
    assert_equal "Mongo", monkey.name
    assert_equal "testapp-monkey-1", monkey.remote_entity_id

    person.monkey = monkey
    assert_equal "Mongo", person.monkey.name
    assert_equal "testapp-monkey-1", person.monkey_id
  end
  
  test "that building a remote entity as an object works" do
    person = Person.new
    person.build_monkey({ :name => "Mongo" })
    
    assert_equal "Mongo", person.monkey.name
    assert_nil person.monkey_id
  end
  
  test "that creating a remote entity as an object works" do
    person = Person.new
    person.create_monkey({ :name => "Mongo" })
    
    assert_equal "Mongo", person.monkey.name
    assert_not_nil person.monkey_id
  end
  
  test "that customizing the class name for a belongs_to_remote_entity association works" do
    person = Person.new
    person.create_big_monkey({ :name => "Mongo" })
    
    assert_equal "Mongo", person.big_monkey.name
    assert_not_nil person.big_monkey.id
  end
  
  test "that destroy dependent option works" do
    Fafactory.purge('testapp')
    res = Fafactory.create('testapp', :monkey)
    id = res["id"]
    remote_entity_id = res["remote_entity_id"]
    person = Person.create({ :big_monkey_id => remote_entity_id })
    assert_not_nil person.big_monkey
    
    person.destroy
    assert_nil Monkey.find(:one, id)
  end
end