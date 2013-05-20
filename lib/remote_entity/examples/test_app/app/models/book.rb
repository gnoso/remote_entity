class Book < RemoteEntity::EntityResource
  self.service = :testapp
  self.version =  1
  
  schema :title, :pages, :author
end