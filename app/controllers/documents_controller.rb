require "uri"
require "net/http"
require "json"

class DocumentsController < ApplicationController
  def create
    @document = Document.create(title: "Untitled Document")
    redirect_to document_path(@document)
  end

  def show
    @document = Document.find(params[:id])
    @pages = @document.pages.order(:position)
  end

  def update
    @document = Document.find(params[:id])

    # Update using the safe, permitted parameters
    if @document.update(document_params)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  # This tells Rails "It is safe to let the user change the title!"
  def document_params
    params.require(:document).permit(:title)
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    redirect_to root_path, notice: "Document was successfully deleted!"
  end
end
