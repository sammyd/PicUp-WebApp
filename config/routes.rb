PicUp::Application.routes.draw do
  
  resources :photos, :only => [:index, :new, :create, :destroy]
  
  root :to => "photos#index"

end
