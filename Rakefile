require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "lib/remote_entity"
  t.test_files = FileList['test/*_test.rb']
  t.verbose  = true
end