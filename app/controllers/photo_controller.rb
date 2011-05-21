class PhotoController < ApplicationController
  
  def index
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
