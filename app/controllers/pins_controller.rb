class PinsController < ApplicationController
  def create
    @page = Page.find(params[:page_id])

    next_number = @page.pins.count + 1

    @page.pins.create(
      x_coordinate: params[:x_coordinate],
      y_coordinate: params[:y_coordinate],
      body: params[:body],
      marker_number: next_number
    )

    redirect_to document_path(@page.document)
  end
end
