class ApplicationController < ActionController::Base
=begin
  #Permite que métodos de uma classe sejam acessados pelos demais controllers da aplicação,
  pois os mesmos extendem ApplicationController.
=end
  delegate :current_user, :user_signed_in?, to: :user_session
  #Para que os métodos do controle seja utilizado nos templates, usamos a class macro helper_method.
  helper_method :current_user, :user_signed_in?

  protect_from_forgery with: :exception

  #Define o filtro que será executado antes das ações, configurando o sistema de internacionalização.
  before_action do
    I18n.locale = params[:locale] || I18n.default_locale
  end

  #Define a opção de idioma padrão para as rotas, caso o idioma não seja informado.
  def default_url_options
    { locale: I18n.locale }
  end

  def user_session
    UserSession.new(session)
  end

=begin
  Lembrar que caso o filtro execute um redirecionamento ou renderizar um template, os filtros
  sequintes não serão executados.
=end

  #Filtro que redireciona o usuário para a página de login com uma mensagem.
  def require_authentication
    #Verifica se a sessão do usuário é inválida.
    unless user_signed_in?
      redirect_to new_user_sessions_path,
            alert: t('flash.alert.needs_login')
    end
  end

  #Filtro que redireciona o usuário para a página principal com uma mensagem.
  def require_no_authentication
    if user_signed_in?
      redirect_to root_path,
            notice: t('flash.notice.already_logged_in')
    end
  end
end
