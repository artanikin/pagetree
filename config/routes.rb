Pagetree::Application.routes.draw do

  get  '(*input_route)/add' => 'pages#new',  as: 'add_page'
  get  '*input_route/edit'  => 'pages#edit', as: 'edit_page'
  post '(*input_route)/'    => 'pages#create'
  get  '*input_route/'      => 'pages#show', as: 'show_page'

  root :to => 'pages#index', as: 'pages'

  resources :pages, path: '/', only: [ :update ]
end