class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #Define o filtro que será executado antes das ações, configurando o sistema de internacionalização.
  before_action do
    I18n.locale = params[:locale] || I18n.default_locale
  end

  #Define a opção de idioma padrão para as rotas, caso o idioma não seja informado.
  def default_url_options
    { locale: I18n.locale }
  end
end
