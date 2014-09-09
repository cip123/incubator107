class TinymceAssetsController < ApplicationController
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed

    asset = Asset.create(:image => params[:file])

    render json: {
      image: {
        url: view_context.image_url(asset.image.url)
      }
    }, content_type: "text/html"
  end
end