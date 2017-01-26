Rails.application.routes.draw do
  #Expressão regular para validar os idiomas suportados.
  LOCALES = /en|pt\-BR/
  
  scope "(:locale)", locale: LOCALES do
    resources :rooms
    resources :users

    #Define uma rota para um recurso singletom, ou seja, no qual apenas a ação show será criada.
    resource :confirmation, only: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:locale' => 'home#index', locale: LOCALES
  root 'home#index'
end
