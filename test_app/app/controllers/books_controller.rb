class BooksController < ApplicationController
  
  # GET /monkeys/new
  # GET /monkeys/new.xml
  def new
    @book = Book.new
  end
  
end
