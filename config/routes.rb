Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  # a RESTful route for Find Similar Movies
  get 'movies/same_director/:id' => 'movies#same_director', :as => :same_director
end
