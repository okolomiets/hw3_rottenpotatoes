Rottenpotatoes::Application.routes.draw do
  resources :movies do
  	member do
  		get 'search_same_director'
  	end
  end
  # map '/' to be a redirect to '/movies'

  post '/movies/search_tmdb'
  

  root :to => redirect('/movies')
end
