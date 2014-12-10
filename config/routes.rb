Rails.application.routes.draw do
    root :to => 'main#index'
    get 'index', :to => 'main#index'
    get 'code', :to => 'main#code'
    post 'compute', :to => 'main#compute'
end
