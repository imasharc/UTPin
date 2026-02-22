require 'uri'
require 'net/http'
require 'json'

class DocumentsController < ApplicationController
  def create
    @document = Document.create(title: "Untitled Document")
    redirect_to document_path(@document)
  end

  def show
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])

    target_url = params[:website_url]
    wants_full_page = (params[:full_page] == "1") 

    base_url = "https://api.microlink.io/"
    api_params = { url: target_url, force: "true" }

    if wants_full_page
      api_params["screenshot.fullPage"] = "true"
    else
      api_params[:screenshot] = "true"
    end

    uri = URI(base_url)
    uri.query = URI.encode_www_form(api_params)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    
    result = JSON.parse(response.body)

    if result["status"] == "success"
      screenshot_url = result.dig("data", "screenshot", "url")
      @document.update(image_url: screenshot_url)
    end

    redirect_to document_path(@document)
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    redirect_to root_path, notice: "Document was successfully deleted!"
  end
end
