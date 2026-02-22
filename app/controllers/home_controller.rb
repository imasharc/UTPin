require 'uri'
require 'net/http'
require 'json'

class HomeController < ApplicationController
  def index
    @documents = Document.order(updated_at: :desc)
  end
end
