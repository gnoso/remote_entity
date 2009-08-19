require 'test/unit'
require 'ruby-debug'
require 'fileutils'
require 'fafactory'

require 'active_record'

require 'lib/remote_entity'

class Test::Unit::TestCase
  # test "verify something" do
  #   ...
  # end
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end
end

# delete the test database and create it again
FileUtils.rm_f('test/test.sqlite3')
FileUtils.cp('test/test_structure.sqlite3', 'test/test.sqlite3')

ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :database => "test/test.sqlite3"
})