class PhotosController < ApplicationController
  
  def index
    @photos = Photo.page(params[:page]).per(30)
    @title = "Uploaded Photos"
  end
  
  def destroy
    @photo = Photo.find(params[:id]).destroy
    flash[:success] = "Photo destroyed successfully"
    redirect_to photos_path
  end
  
  def new
    @photo = Photo.new
    @title = "Manual Upload"
  end
  
  def create
    @ip = request.remote_ip
    @browser = request.env["HTTP_USER_AGENT"]
    @attr = params[:photo].merge({ :fromIP => @ip, :browserDetails => @browser })
    @photo = Photo.new(@attr)
    if @photo.save
      flash[:success] = "Photo uploaded successfully"
      redirect_to photos_path
    else
      flash[:error]   = "There was a problem uploading the photo"
      render :new
    end
  end
end
