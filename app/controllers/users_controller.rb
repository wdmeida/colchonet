class UsersController < ApplicationController
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
            render action: :edit
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
end