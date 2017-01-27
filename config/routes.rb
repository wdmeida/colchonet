Rails.application.routes.draw do
  #Expressão regular para validar os idiomas suportados.
  LOCALES = /en|pt\-BR/
  
  scope "(:locale)", locale: LOCALES do
    resources :rooms
    resources :users

    #Define uma rota para um recurso singletom, ou seja, no qual apenas a ação show será criada.
    resource :confirmation, only: [:show]

    #Define a rota para os recursos utilizados para sessão do usuário (create, new e destroy).
    resource :user_sessions, only: [:create, :new, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:locale' => 'home#index', locale: LOCALES
  root 'home#index'
end
