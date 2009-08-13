class Monkey < ActiveRecord::Base
  
  validates_presence_of :name
  
  attr_accessor :remote_entity_id
  def remote_entity_id
    if id
      return "testapp-monkey-#{id}"
    else
      return nil
    end
  end
  
  private
  def to_xml(options = {})
    if !options[:methods]
      options[:methods] = [ :remote_entity_id ]
    else
      options[:methods] << :remote_entity_id
    end
    
    super(options)
  end
end
