class UsersController < ApplicationController
    #Aplica o filtro para liberar do login para as ações new e create dos perfis de usuários.
    before_action :require_no_authentication, only: [:new, :create]
    #Aplica o filtro (can_change) antes da ações serem executadas (edit e update).
    before_action :can_change, only: [:edit, :update]

    #Cria um novo recurso.
    def new
        #Cria uma nova instância do modelo User e armazena em uma variável de instância @user.
        #O controller compartilha as variáveis de instância com o template.
        @user = User.new
    end

    #Exibe as informações de um recurso específico.
    def show
        @user = User.find(params[:id])
    end

    #Salva o recurso criado.
    def create
        #O método user_params retorna um hash com todos os parâmetros enviados pelo usuário.
        @user = User.new(user_params)
        if @user.save
            SignupMailer.confirm_email(@user).deliver

            redirect_to @user, 
                        :notice => 'Cadastro criado com sucesso!'
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to @user,
                notice: 'Cadastro atualizado com sucesso!'
        else
            render :edit
        end
    end

    private

    def user_params
        #Verifica a presença da chave :user nos parâmetros vindos do usuário. Se existir,
        #retorna os parâmetros da chave, caso contrário dispara a exceção ActionController::ParameterMissing.
        params.
            require(:user).
            permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
    end

    #Comprao id do usuário na rota com o usuário da sessão, caso sejam diferentes redireciona para
    #a visualização do perfil.
    def can_change
        unless user_signed_in? && current_user == user
            redirect_to user_path(params[:id])
        end
    end

    def user
        #Caso a variável não tenha sido inicializada, busca o valor no banco e a inicializa como um chache.
        @user ||= User.find(params[:id])
    end
end