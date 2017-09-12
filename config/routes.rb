Rails.application.routes.draw do
  devise_for :users
  # get 'tasks/show'

  # get 'tasks/new'

  # get 'tasks/edit'

  ################################################################
  #             Replace above with NESTED routes below           #
  ################################################################

  # get 'pages/contact'
  get "contact", to: "pages#contact"

  # get 'pages/about'
  get "about", to: "pages#about"
  #Now our URL won't have to have /pages/about
  #Instead we can simply do: 
  # => localhost:3000/about
  # and we will get to the SAME PAGE!!

  get "error", to: "pages#error"

  #Here's how to do a redirect
  get "blog", to: redirect("http://www.moncurewebdevelopement.com")
  #With this, if anyone enters /blog, they will be redirected to my website!!!!

  # resources :projects
  # # The priority is based upon order of creation: first created -> highest priority.
  # # See how all your routes lay out with "rake routes".



  ####################     NESTED ROUTES     #######################
  # The resources line can actually become a block!
  resources :projects do
    resources :tasks, except: [:index], controller: 'projects/tasks'
  end
  ##################################################################



  # Home page will typically be very last, except for a catch-all 404
  root 'pages#home'


  #Catch-all Error-handling 404 page ***ALWAYS ON BOTTOM !!!****
  get "*path", to: redirect("/error")
  #But we still need to create a route for this

end
