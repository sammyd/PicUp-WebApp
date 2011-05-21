class PhotosController < ApplicationController
  
  def index
    @photos = Photo.page(params[:page])
  end
  
  def destroy
    render :text => "photos#destroy"
  end
  
  def new
  end
  
  def create
    render :text => "photos#create"
  end
end
