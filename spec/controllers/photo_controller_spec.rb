require 'spec_helper'

describe PhotoController do

  render_views
  
  describe "GET 'index'" do
    before(:each) do
      @photos = []
      3.times do
        @photos << Factory(:photo,  :fromIP => Factory.next(:ip),
                                    :browserDetails => Factory.next(:browser))
      end
    end
    
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should show the right title" do
      get :index
      response.should have_selector("title", :content => "PicUp | Uploaded Photos:")
    end
    
    it "should display images for each of the Photo objects" do
      get :index
      @photos.each do |p|
        response.should have_selector("img", :src => p.image.url)
      end
    end
    
    it "should have a link to the original for each image" do
      get :index
      @photos.each do |p|
        response.should have_selector("a", :href => p.image.url)
      end
    end
    
    describe "pagination" do
      before(:each) do
        30.times do
          @photos << Factory(:photo,  :fromIP => Factory.next(:ip),
                                      :browserDetails => Factory.next(:browser))
        end
      end
          
      it "should paginate the photos" do
        get :index
        pending
      end
      
      it "should have images for the elements on the first page" do
        get :index
        @photos[0..29].each do |p|
          response.should have_selector("img", :src => p.image.url)
        end
      end
      
      it "shouldn't have images for the extra elements" do
        get :index
        @photos[30..32].each do |p|
          response.should_not have_selector("img", :src => p.image.url)
        end
      end
    end
    
    it "should show the IP address for incoming images" do
      get :index
      @photos.each do |p|
        response.should have_selector("li", :content => p.fromURL)
      end
    end
    
    it "should show the browser summary for incoming images" do
      get :index
      @photos.each do |p|
        response.should have_selector("li", :content => p.browserDetails)
      end
    end
  end
  
  describe "GET 'new'" do
    it "be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "PicUp | Manual Upload")
    end
    
    describe "form" do
      it "should have the right form" do
        get :new
        response.should have_selector("form", :action => "/photos", :method => "POST")
      end
      
      it "should have a photo upload box" do
        get :new
        response.should have_selector("input", :type => "file", :name => "photo[image]")
      end
      
      it "should have a submit button" do
        get :new
        response.should have_selector("input", :type => "submit")
      end
    end
  end
  
  describe "POST 'create'" do
    describe "success" do
      before(:each) do
        @attr = { :image => File.new(Rails.root.join("spec/fixtures/sample.jpg")) }
      end
    
      it "should be successful" do
        post :create, :photo => @attr
        response.should be_success
      end
    
      it "should create a photo" do
        lambda do
          post :create, :photo => @attr
        end.should change(Photo, :count).by(1)
      end
    end
    
    describe "failure" do
      before(:each) do
        @attr = {}
      end
      
      it "should not create a photo" do
        lambda do
          post :create, :photo => @attr
        end.should_not change(Photo, :count)
      end
      
      it "should give a flash error message" do
        post :create, :photo => @attr
        flash[:error] =~ /failed to upload photo/i
      end
      
      it "should render the new action" do
        post :create, :photo => @attr
        response.should render_template(:new)
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @photo = Factory(:photo)
    end
    
    it "should delete a photo" do
      lambda do
        delete :destroy, :id => @photo
      end.should change(Photo, :count).by(-1)
    end
    
    it "should delete the correct photo" do
      delete :destroy, :id => @photo
      Photo.find_by_id(@photo).should be_nil
    end
    
    it "should redirect to the index action" do
      delete :destroy, :id => @photo
      response.should redirect_to :index
    end
    
    it "should show a success message" do
      delete :destroy, :id => @photo
      flash[:succes] =~ /photo deleted successfully/i
    end
    
    it "should show an error in case of failure" do
      delete :destroy, :id => nil
      flash[:error] =~ /there was an error/i
    end
  end
end
