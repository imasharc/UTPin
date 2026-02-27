require "net/http"
require "json"

class PagesController < ApplicationController
  def create
    @document = Document.find(params[:document_id])
    position = @document.pages.count + 1

    if params[:file].present?
      @document.pages.create!(image: params[:file], position: position)
    
    elsif params[:website_url].present?
      target_url = params[:website_url]
      base_url = "https://api.microlink.io/"
      api_params = { url: target_url, screenshot: "true", "screenshot.fullPage": "true", force: "true" }
      uri = URI(base_url)
      uri.query = URI.encode_www_form(api_params)
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)

      if result["status"] == "success"
        screenshot_url = result.dig("data", "screenshot", "url")
        # Create a new Page at the end of the list
        @document.pages.create(image_url: screenshot_url, position: position)
      end
    end

    redirect_to document_path(@document)
  end
end
