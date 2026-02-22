class PinsController < ApplicationController
  def create
    @document = Document.find(params[:document_id])

    next_number = @document.pins.count + 1

    @document.pins.create(
      x_coordinate: params[:x_coordinate],
      y_coordinate: params[:y_coordinate],
      body: params[:body],
      marker_number: next_number
    )

    redirect_to document_path(@document)
  end
end
