# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    get 'dashboard', :to => 'dashboard#index'
end
