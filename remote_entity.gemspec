PKG_VERSION = "0.0.2"

Gem::Specification.new do |s|

  s.name = 'remote_entity'
  s.version = PKG_VERSION
  s.platform = Gem::Platform::RUBY
  s.description = <<-DESC.strip.gsub(/\n\s+/, " ")
    Remote Entity defines a pattern for working with REST services. It defines a versioning scheme, a remote entity identifier scheme, and adds some useful features to ActiveRecord and ActiveResource for working with those schemes.
  DESC
  s.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Remote Entity defines a pattern for working with REST services.
  DESC

  s.files = %w(lib/remote_entity.rb lib/remote_entity/entity_record.rb lib/remote_entity/entity_record_associations.rb lib/remote_entity/entity_resource.rb lib/remote_entity/remote_entity.rb)
  s.require_path = 'lib'
  s.has_rdoc = true

  s.author = "Gnoso, Inc."
  s.email = "alan@gnoso.com"
  s.homepage = "http://www.gnoso.com"

  s.add_dependency('activeresource', '>= 2.0')
  s.add_dependency('activerecord', '>= 2.0')
end
